import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playx/playx.dart';

void main() {
  Playx.runPlayx(
    appConfigBuilder: () => AppConfig(),
    themeConfigBuilder: () => AppThemeConfig.createThemeConfig(),
    localeConfigBuilder: () => AppLocaleConfig.createLocaleConfig(),
    envSettingsBuilder: () =>
        const PlayxEnvSettings(fileName: 'assets/env/keys.env'),
    securePrefsSettings: const PlayxSecurePrefsSettings(
      androidOptions: AndroidOptions.defaultOptions,
    ),
    // sentryOptions: (options) {
    //   options.dsn = '';
    //   options.tracesSampleRate = 1.0;
    //   options.attachScreenshot = true;
    //   options.captureFailedRequests = true;
    // },
    appRunner: () => runApp(const ProviderScope(child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayxPlatformApp(
      navigationSettings: PlayxNavigationSettings.goRouter(
        goRouter: AppPages.router,
        builder: (context, child) {
          return ConnectionStatusWidget(
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
      // preferredOrientations: const [
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.landscapeLeft,
      //   DeviceOrientation.landscapeRight,
      // ],
      themeSettings: PlayxThemeSettings(
        theme: ThemeData(fontFamily: fontFamily()),
      ),
      screenSettings: const PlayxScreenSettings(
        fontSizeResolver: FontSizeResolvers.radius,
      ),
      appSettings: PlayxAppSettings(
        title: AppTrans.appName.tr(),
        scrollBehavior: DefaultAppScrollBehavior(),
      ),
    );
  }
}
