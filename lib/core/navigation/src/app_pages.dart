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
        canShowNavigationRail: NavigationUtils.showNavigationRail,
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.dashboard,
            name: Routes.dashboard,
            builder: (ctx, state) => DashboardView(),
            binding: DashboardBinding(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.wishlist,
            name: Routes.wishlist,
            builder: (ctx, state) {
              return WishlistView();
            },
            binding: WishlistBinding(),
            routes: [
              PlayxRoute(
                path: Paths.wishlistDetails,
                name: Routes.wishlistDetails,
                builder: (ctx, state) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Wishlist Details'),
                    ),
                  );
                },
                binding: WishlistDetailsBinding(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.products,
            name: Routes.products,
            builder: (ctx, state) => const ProductsView(),
            routes: [
              PlayxRoute(
                path: Paths.productDetails,
                name: Routes.productDetails,
                builder: (ctx, state) {
                  final productId =
                      int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
                  return ProductDetailsView(productId: productId);
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          PlayxRoute(
            path: Paths.settings,
            name: Routes.settings,
            builder: (ctx, state) => const SettingsView(),
            binding: SettingsBinding(),
          ),
        ],
      ),
    ],
  );

  static final routes = [
    PlayxRoute(
      path: Paths.splash,
      name: Routes.splash,
      builder: (context, state) => const SplashView(),
      binding: SplashBinding(),
    ),
    PlayxRoute(
      path: Paths.login,
      name: Routes.login,
      builder: (context, state) => const LoginView(),
      binding: LoginBinding(),
    ),
    PlayxRoute(
      path: Paths.register,
      name: Routes.register,
      builder: (context, state) => const RegisterView(),
      binding: RegisterBinding(),
    ),
    PlayxRoute(
      path: Paths.onboarding,
      name: Routes.onboarding,
      builder: (context, state) => OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    _homeNavigationRoutes,
  ];
}
