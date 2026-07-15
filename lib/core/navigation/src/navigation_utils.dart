part of '../navigation.dart';

class NavigationUtils {
  const NavigationUtils._();

  static List<String> get mainRoutes => [
    Routes.dashboard,
    Routes.wishlist,
    Routes.countries,
    Routes.settings,
  ];

  static List<String> get routesBottomNav => [
    Routes.dashboard,
    Routes.wishlist,
    Routes.countries,
    Routes.settings,
  ];

  static bool get showBottomNav {
    final location = AppPages.router.routerDelegate.currentConfiguration.uri.path;
    return routesBottomNav.any((route) => location.contains(route));
  }

  static bool get canShowDrawer => true; //AppUtils.isMobile();

  static GlobalKey<NavigatorState> get navigatorKey => AppPages.router.routerDelegate.navigatorKey;

  static BuildContext? get navigationContext => navigatorKey.currentContext;
}
