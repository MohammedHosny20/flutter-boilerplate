part of '../navigation.dart';

/// This class is responsible for handling the app navigation.
/// for each navigation from screen to another add it here.
abstract class AppNavigation {
  const AppNavigation._();

  static GoRouter get _router => AppPages.router;

  static void navigateFormSplashToHome() {
    _router.goNamed(AppPages.homeRoute);
  }

  static void navigateToHome() {
    _router.goNamed(AppPages.homeRoute);
  }

  static void navigateFormSplashToLogin() {
    _router.goNamed(Routes.login);
  }

  static void navigateFromLoginToRegister() {
    _router.pushNamed(Routes.register);
  }

  static void navigateFromLoginToHome() {
    _router.goNamed(AppPages.homeRoute);
  }

  static void navigateFromRegisterToLogin() {
    _router.goNamed(Routes.login);
  }

  static void navigateFromRegisterToHome() {
    _router.goNamed(AppPages.homeRoute);
  }

  static void navigateToSplash() {
    _router.goNamed(Routes.splash);
  }

  static void navigateFromSplashToOnBoarding() {
    _router.goNamed(Routes.onboarding);
  }

  static void navigateFromOnBoardingToLogin() {
    _router.goNamed(Routes.login);
  }

  static void navigateFromVerifyOtpToHome() {
    _router.goNamed(AppPages.homeRoute);
  }

  static void navigateFromLoginToVerifyPhone() {
    _router.pushNamed(Routes.verifyPhone);
  }

  static void navigateToOtpLogin() {
    _router.pushNamed(Routes.otpLogin);
  }

  static void navigateFromOtpLoginToVerifyPhone() {
    _router.pushNamed(Routes.verifyPhone);
  }

  static void navigateToCountryDetails({required String code}) {
    _router.pushNamed(
      Routes.countryDetails,
      pathParameters: {'code': code},
    );
  }

  static void navigateFromSettingsToLogin() {
    _router.goNamed(Routes.login);
  }

  static void navigateToLogin() {
    _router.goNamed(Routes.login);
  }

  static void navigateToCountries() {
    _router.pushNamed(Routes.countries);
  }
}
