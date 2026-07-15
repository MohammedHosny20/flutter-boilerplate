part of '../imports/register_imports.dart';

class RegisterState {
  final bool hidePassword;
  final bool hideConfirmPassword;
  final bool agreeToTerms;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isFormValid;
  final LoginMethod? currentLoginMethod;

  RegisterState({
    this.hidePassword = true,
    this.hideConfirmPassword = true,
    this.agreeToTerms = true,
    this.isFirstNameValid = false,
    this.isLastNameValid = false,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
    this.isFormValid = false,
    this.currentLoginMethod,
  });

  RegisterState copyWith({
    bool? hidePassword,
    bool? hideConfirmPassword,
    bool? agreeToTerms,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isFormValid,
    LoginMethod? currentLoginMethod,
  }) {
    return RegisterState(
      hidePassword: hidePassword ?? this.hidePassword,
      hideConfirmPassword: hideConfirmPassword ?? this.hideConfirmPassword,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
      currentLoginMethod: currentLoginMethod ?? this.currentLoginMethod,
    );
  }
}

class RegisterController extends Notifier<RegisterState> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// This needed for text field that has complex ui like hide password button
  /// As using [TextInputAction.next] to move keyboard to next field won't work
  /// as the button will take focus so we need to manually add text field current and next focus node
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  final confirmPasswordFormKey = GlobalKey<FormState>();

  final loginMethods = <LoginMethod>[
    LoginMethod.email,
    LoginMethod.google,
    LoginMethod.apple,
  ];

  @override
  RegisterState build() {
    return RegisterState();
  }

  void _updateFormValidity() {
    final isValid =
        state.agreeToTerms &&
        state.isFirstNameValid &&
        state.isLastNameValid &&
        state.isEmailValid &&
        state.isPasswordValid &&
        state.isConfirmPasswordValid;
    state = state.copyWith(isFormValid: isValid);
  }

  void setFirstNameValid(bool value) {
    state = state.copyWith(isFirstNameValid: value);
    _updateFormValidity();
  }

  void setLastNameValid(bool value) {
    state = state.copyWith(isLastNameValid: value);
    _updateFormValidity();
  }

  void setEmailValid(bool value) {
    state = state.copyWith(isEmailValid: value);
    _updateFormValidity();
  }

  void setPasswordValid(bool value) {
    state = state.copyWith(isPasswordValid: value);
    _updateFormValidity();
  }

  void setConfirmPasswordValid(bool value) {
    state = state.copyWith(isConfirmPasswordValid: value);
    _updateFormValidity();
  }

  void setAgreeToTerms(bool value) {
    state = state.copyWith(agreeToTerms: value);
    _updateFormValidity();
  }

  Future<void> registerBy({required LoginMethod method}) async {
    if (method == LoginMethod.email) {
      state = state.copyWith(currentLoginMethod: LoginMethod.email);
    } else {
      ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.register();
      state = state.copyWith();
      final authRepo = await ref.read(authRepositoryProvider.future);
      final result = await authRepo.loginViaAuth0(method: method);
      result.when(
        success: (User user) async {
          _navigateToHome();
        },
        error: (NetworkException exception) {
          ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.idle();
          Alert.error(message: exception.message);
        },
      );
    }
  }

  Future<void> register() async {
    if (!state.isFormValid) return;
    ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.register();

    final authRepo = await ref.read(authRepositoryProvider.future);
    final result = await authRepo.register(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (User user) async {
        _navigateToHome();
      },
      error: (NetworkException exception) {
        Alert.error(message: exception.message);
        ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.idle();
      },
    );
  }

  Future<void> _navigateToHome() async {
    ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.idle();
    AppNavigation.navigateFromRegisterToHome();
  }

  void changeHidePasswordState() {
    state = state.copyWith(hidePassword: !state.hidePassword);
  }

  void changeHideConfirmPasswordState() {
    state = state.copyWith(hideConfirmPassword: !state.hideConfirmPassword);
  }

  void setCurrentLoginMethod(LoginMethod? method) {
    state = state.copyWith(currentLoginMethod: method);
  }

  void navigateToLogin() {
    AppNavigation.navigateFromRegisterToLogin();
  }
}

final registerControllerProvider = NotifierProvider<RegisterController, RegisterState>(
  RegisterController.new,
);
