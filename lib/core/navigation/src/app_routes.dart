// ignore_for_file: constant_identifier_names
part of '../navigation.dart';

/// app routes names.
abstract class Routes {
  static const splash = 'splash';
  static const login = 'login';
  static const otpLogin = 'otpLogin';
  static const verifyPhone = 'verifyPhone';
  static const register = 'register';
  static const onboarding = 'onboarding';
  static const settings = 'settings';
  static const dashboard = 'dashboard';
  static const wishlist = 'wishlist';
  static const wishlistDetails = 'wishlistDetails';
  static const countries = 'countries';
  static const countryDetails = 'countryDetails';
}

/// app routes paths.
abstract class Paths {
  static const splash = '/';
  static const login = '/login';
  static const otpLogin = '/otp-login';
  static const verifyPhone = '/otp';
  static const register = '/register';
  static const onboarding = '/onboarding';
  static const settings = '/settings';
  static const dashboard = '/dashboard';
  static const wishlist = '/wishlist';
  static const wishlistDetails = 'details';
  static const countries = '/countries';
  static const countryDetails = 'details/:code';
}
