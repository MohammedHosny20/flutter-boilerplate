part of '../imports/verify_phone_view_imports.dart';

///Login controller to setup data to the ui.
class VerifyPhoneState {
  final bool isLoading;
  final bool isOtpValid;
  final String currentPin;
  final bool showScrollPadding;

  VerifyPhoneState({
    this.isLoading = false,
    this.isOtpValid = false,
    this.currentPin = '',
    this.showScrollPadding = true,
  });

  VerifyPhoneState copyWith({
    bool? isLoading,
    bool? isOtpValid,
    String? currentPin,
    bool? showScrollPadding,
  }) {
    return VerifyPhoneState(
      isLoading: isLoading ?? this.isLoading,
      isOtpValid: isOtpValid ?? this.isOtpValid,
      currentPin: currentPin ?? this.currentPin,
      showScrollPadding: showScrollPadding ?? this.showScrollPadding,
    );
  }
}

class VerifyPhoneController extends Notifier<VerifyPhoneState> {
  @override
  VerifyPhoneState build() {
    return VerifyPhoneState();
  }

  Future<void> verifyOtp() async {
    state = state.copyWith(showScrollPadding: false);
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if (!state.isOtpValid) return;
    state = state.copyWith(isLoading: true);

    final authRepo = await ref.read(authRepositoryProvider.future);
    final result = await authRepo.verifyOtpCode(
      pin: state.currentPin,
    );

    result.when(
      success: (user) async {
        state = state.copyWith(isLoading: false);
        AppNavigation.navigateFromVerifyOtpToHome();
      },
      error: (NetworkException exception) {
        state = state.copyWith(isLoading: false);
        Alert.error(message: exception.message);
      },
    );
  }

  void handleOtpPinChanged(String value) {
    state = state.copyWith(
      showScrollPadding: true,
      currentPin: value,
      isOtpValid: isOtpCodeValidNumber(value),
    );
  }

  void setOtpValid(bool value) {
    state = state.copyWith(isOtpValid: value);
  }

  void setShowScrollPadding(bool value) {
    state = state.copyWith(showScrollPadding: value);
  }

  bool isOtpCodeValidNumber(String value) {
    final number = num.tryParse(value);
    if (number == null) {
      return false;
    }
    if (number > 1000) {
      return true;
    }
    return false;
  }

  void resendCode() {}
}

final verifyPhoneControllerProvider = NotifierProvider<VerifyPhoneController, VerifyPhoneState>(
  VerifyPhoneController.new,
);
