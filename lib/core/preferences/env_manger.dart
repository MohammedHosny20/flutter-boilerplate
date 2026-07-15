import 'package:playx/playx.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class EnvManger {
  const EnvManger._();
  static const EnvManger instance = EnvManger._();

  final String _sentryKey = 'SENTRY_KEY';
  final String _showVersionCodeKey = 'SHOW_VERSION_CODE';
  Future<String> get sentryKey => PlayxEnv.getString(_sentryKey);

  Future<bool> get showVersionCode => PlayxEnv.getBool(_showVersionCodeKey);
}
