part of '../imports/login_view_imports.dart';

///Login controller to setup data to the ui.
class OtpLoginState {
  final bool isLoading;
  final bool isPhoneNumberValid;

  OtpLoginState({
    this.isLoading = false,
    this.isPhoneNumberValid = false,
  });

  OtpLoginState copyWith({
    bool? isLoading,
    bool? isPhoneNumberValid,
  }) {
    return OtpLoginState(
      isLoading: isLoading ?? this.isLoading,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
    );
  }
}

class OtpLoginController extends Notifier<OtpLoginState> {
  final phoneController = TextEditingController();

  @override
  OtpLoginState build() {
    if (kDebugMode) {
      // phoneController.text = '1121221';
      // state = state.copyWith(isPhoneNumberValid: true);
    }
    return OtpLoginState();
  }

  void setPhoneNumberValid(bool value) {
    state = state.copyWith(isPhoneNumberValid: value);
  }

  Future<void> login() async {
    if (!state.isPhoneNumberValid) return;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    state = state.copyWith(isLoading: true);
    final authRepo = await ref.read(authRepositoryProvider.future);
    final result = await authRepo.otpLogin(
      phoneNumber: phoneController.text,
    );
    result.when(
      success: (user) async {
        state = state.copyWith(isLoading: false);
        AppNavigation.navigateFromLoginToVerifyPhone();
      },
      error: (NetworkException exception) {
        state = state.copyWith(isLoading: false);
        Alert.error(message: exception.message);
      },
    );
  }

  void navigateToRegister() {
    AppNavigation.navigateFromLoginToRegister();
  }
}

final otpLoginControllerProvider = NotifierProvider<OtpLoginController, OtpLoginState>(
  OtpLoginController.new,
);
