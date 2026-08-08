part of '../imports/app_imports.dart';

class AppController extends GetxController {
  static AppController get instance => Get.find<AppController>();

  int currentDrawerIndex = 0;
  int currentBottomNavIndex = 0;

  final showBottomNav = true.obs;
  final loadingStatus = Rx(const LoadingStatus.idle());

  late final List<CustomNavigationDestinationItem> bottomNavItems = [
    CustomNavigationDestinationItem(
      icon: IconInfo(icon: CupertinoIcons.house),
      label: AppTrans.home,
      navigationIndex: 0,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(icon: CupertinoIcons.heart),
      label: AppTrans.wishlist,
      navigationIndex: 1,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(icon: CupertinoIcons.cube_box),
      label: AppTrans.products,
      navigationIndex: 2,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(icon: CupertinoIcons.settings),
      label: AppTrans.settings,
      navigationIndex: 3,
    ),
  ];

  void updateBottomNavIndex(int index) {
    if (index < bottomNavItems.length) {
      currentBottomNavIndex = index;
    } else if (index < 0) {
      currentBottomNavIndex = 0;
    }
  }

  void handleBottomNavItemChanged({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    PlayxNavigation.goToBranch(index: index, navigationShell: navigationShell);
  }

  void updateDrawerIndex(int index) {
    if (index < bottomNavItems.length) {
      currentDrawerIndex = index;
    } else if (index < 0) {
      currentDrawerIndex = 0;
    }
  }

  void handleDrawerItemChanged({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    if (index == bottomNavItems.length) {
      handleLogout();
      return;
    }
    PlayxNavigation.goToBranch(index: index, navigationShell: navigationShell);
  }

  Future<void> handleLogout(
      {bool showLoadingOverlay = true, bool navigateToLogin = true}) async {
    if (showLoadingOverlay) {
      _updateLoginStatus(isLoggingOut: true);
    }
    await ApiHelper.instance.logout();
    await Future.delayed(const Duration(milliseconds: 200));
    _updateLoginStatus(isLoggingOut: false);
    if (navigateToLogin) {
      AppNavigation.navigateToLogin();
    }
  }

  void _updateLoginStatus({required bool isLoggingOut}) {
    loadingStatus.value = isLoggingOut
        ? const LoadingStatus.logout()
        : const LoadingStatus.idle();
    showBottomNav.value = !isLoggingOut;
  }
}
