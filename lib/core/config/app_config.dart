import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/database/app_database.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_boilerplate/core/preferences/secure_storage_manager.dart';
import 'package:playx/playx.dart';

late PlayxBaseLogger myLogger;

/// This class contains app configuration like playx configuration.
/// After the Riverpod migration, dependency wiring is handled lazily
/// by Riverpod providers (see `lib/core/providers.dart`). This class
/// only initialises infrastructure that must be ready before the
/// ProviderScope tree is built.
class AppConfig extends PlayXAppConfig {
  // setup and boot your dependencies here
  @override
  Future<void> boot() async {
    //USED FOR DEBUGGING
    WidgetsFlutterBinding.ensureInitialized();

    myLogger = PlayxLogger.initLogger(name: 'MY APP');

    await AppDatabase.init();
    await ApiClient.init();
  }

  @override
  Future<void> asyncBoot() async {
    await SecureStorageManager.init();
  }
}
