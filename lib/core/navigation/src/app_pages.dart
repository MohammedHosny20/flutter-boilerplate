part of '../navigation.dart';

/// contains all possible routes for the application.
class AppPages {
  AppPages._();

  static const initial = Paths.splash;
  static const homeRoute = Routes.dashboard;

  static final router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    routes: routes,
    observers: [
      SentryNavigatorObserver(),
    ],
  );

  static final _homeNavigationRoutes = StatefulShellRoute.indexedStack(
    pageBuilder: (context, state, navigationShell) {
      return CustomPageScaffold.buildNavigationShellPage(
        state: state,
        navigationShell: navigationShell,
        showBottomNav: NavigationUtils.showBottomNav,
        canShowDrawer: NavigationUtils.canShowDrawer,
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Paths.dashboard,
            name: Routes.dashboard,
            builder: (ctx, state) => const DashboardView(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Paths.wishlist,
            name: Routes.wishlist,
            builder: (ctx, state) {
              return const WishlistView();
            },
            routes: [
              GoRoute(
                path: Paths.wishlistDetails,
                name: Routes.wishlistDetails,
                builder: (ctx, state) {
                  final item = state.extra;
                  if (item is WishlistItem) {
                    return WishlistDetailsView(item: item);
                  }
                  return const Scaffold(
                    body: Center(
                      child: Text('Wishlist Details'),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Paths.countries,
            name: Routes.countries,
            builder: (ctx, state) => const CountriesListView(),
            routes: [
              GoRoute(
                path: Paths.countryDetails,
                name: Routes.countryDetails,
                builder: (ctx, state) {
                  final code = state.pathParameters['code'] ?? '';
                  return CountryDetailsView(code: code);
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: Paths.settings,
            name: Routes.settings,
            builder: (ctx, state) => const SettingsView(),
          ),
        ],
      ),
    ],
  );

  static final routes = [
    GoRoute(
      path: Paths.splash,
      name: Routes.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: Paths.login,
      name: Routes.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: Paths.otpLogin,
      name: Routes.otpLogin,
      builder: (context, state) => const OtpLoginView(),
    ),
    GoRoute(
      path: Paths.verifyPhone,
      name: Routes.verifyPhone,
      builder: (context, state) => const VerifyPhoneView(),
    ),
    GoRoute(
      path: Paths.register,
      name: Routes.register,
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: Paths.onboarding,
      name: Routes.onboarding,
      builder: (context, state) => const OnBoardingView(),
    ),
    _homeNavigationRoutes,
  ];
}
