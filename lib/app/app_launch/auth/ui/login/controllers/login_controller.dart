part of '../imports/login_imports.dart';

class LoginState {
  final bool hidePassword;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;
  final LoginMethod? currentLoginMethod;

  const LoginState({
    this.hidePassword = true,
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isFormValid = false,
    this.currentLoginMethod,
  });

  LoginState copyWith({
    bool? hidePassword,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isFormValid,
    LoginMethod? currentLoginMethod,
  }) {
    return LoginState(
      hidePassword: hidePassword ?? this.hidePassword,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFormValid: isFormValid ?? this.isFormValid,
      currentLoginMethod: currentLoginMethod ?? this.currentLoginMethod,
    );
  }
}

class LoginController extends Notifier<LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final loginMethods = <LoginMethod>[
    LoginMethod.email,
    LoginMethod.phone,
    LoginMethod.google,
    LoginMethod.apple,
  ];

  @override
  LoginState build() {
    return const LoginState();
  }

  void _updateFormValidity() {
    state = state.copyWith(
      isFormValid: state.isEmailValid && state.isPasswordValid,
    );
  }

  void setEmailValid(bool value) {
    state = state.copyWith(isEmailValid: value);
    _updateFormValidity();
  }

  void setPasswordValid(bool value) {
    state = state.copyWith(isPasswordValid: value);
    _updateFormValidity();
  }

  void toggleHidePassword() {
    state = state.copyWith(hidePassword: !state.hidePassword);
  }

  void setCurrentLoginMethod(LoginMethod? method) {
    state = state.copyWith(currentLoginMethod: method);
  }

  Future<void> loginBy({required LoginMethod method}) async {
    if (method == LoginMethod.email) {
      setCurrentLoginMethod(LoginMethod.email);
    } else if (method == LoginMethod.phone) {
      AppNavigation.navigateToOtpLogin();
    } else {
      setCurrentLoginMethod(null);
      ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.login();

      final authRepo = await ref.read(authRepositoryProvider.future);
      final result = await authRepo.loginViaAuth0(method: method);
      result.when(
        success: (User user) {
          _navigateToHome();
        },
        error: (NetworkException exception) {
          Alert.error(message: exception.message);
          ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.idle();
        },
      );
    }
  }

  Future<void> login() async {
    if (!state.isFormValid) return;
    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.login();
    final authRepo = await ref.read(authRepositoryProvider.future);
    final result = await authRepo.loginViaEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (User user) async {
        await _navigateToHome();
      },
      error: (NetworkException exception) {
        ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.idle();
        Alert.error(message: exception.message);
      },
    );
  }

  Future<void> _navigateToHome() async {
    ref.read(appControllerProvider.notifier).loadingStatus.value = const LoadingStatus.idle();
    AppNavigation.navigateFromLoginToHome();
  }

  void navigateToRegister() {
    AppNavigation.navigateFromLoginToRegister();
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(LoginController.new);
