part of '../imports/splash_imports.dart';

class SplashState {
  final bool showVersionCode;

  SplashState({this.showVersionCode = false});

  SplashState copyWith({bool? showVersionCode}) {
    return SplashState(showVersionCode: showVersionCode ?? this.showVersionCode);
  }
}

class SplashController extends Notifier<SplashState> {
  final bool isBiometricAuthEnabled = false;
  final Completer<bool> shouldUpdateApp = Completer();
  final Completer<bool> isAnimationCompleted = Completer();

  @override
  SplashState build() {
    Future.microtask(() => _init());
    return SplashState();
  }

  Future<void> _init() async {
    updateAppVersion();
    _checkAnimationCompleted();
    checkAppVersionAndNavigateToNextPage();
  }

  void _checkAnimationCompleted() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!isAnimationCompleted.isCompleted) {
        isAnimationCompleted.complete(true);
      }
    });
  }

  Future<void> updateAppVersion() async {
    final showVersion = await EnvManger.instance.showVersionCode;
    state = state.copyWith(showVersionCode: showVersion);
  }

  Future<void> checkAppVersionAndNavigateToNextPage({
    bool shouldCheckVersion = false,
  }) async {
    if (shouldCheckVersion) {
      final doesAppNeedUpdate = await shouldUpdateApp.future;
      if (doesAppNeedUpdate) return;
    }

    await Playx.asyncBootFuture();
    if (!kIsWeb) {
      await isAnimationCompleted.future;
    }
    final isLandscape = ScreenUtil().orientation == Orientation.landscape;
    final isOnBoardingShown = await MyPreferenceManger.instance.isOnBoardingShown;
    if (!isOnBoardingShown && !isLandscape) {
      AppNavigation.navigateFromSplashToOnBoarding();
      return;
    }

    final isUserLoggedIn = await ApiHelper.instance.isLoggedIn(
      checkAuth0: false,
    );
    if (!isUserLoggedIn) {
      AppNavigation.navigateFormSplashToLogin();
      return;
    }
    AppNavigation.navigateFormSplashToHome();
  }

  void handleAnimationCompleted(AnimationController controller) {
    if (!isAnimationCompleted.isCompleted) {
      isAnimationCompleted.complete(true);
    }
  }
}

final splashControllerProvider = NotifierProvider<SplashController, SplashState>(
  SplashController.new,
);
