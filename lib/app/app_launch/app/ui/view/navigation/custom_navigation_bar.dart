part of '../../imports/app_imports.dart';

PlatformNavBar buildCustomNavigationBar({
  required BuildContext context,
  required WidgetRef ref,
  required StatefulNavigationShell navigationShell,
}) {
  final state = ref.watch(appControllerProvider);
  final controller = ref.read(appControllerProvider.notifier);
  controller.updateBottomNavIndex(navigationShell.currentIndex);

  return CustomPlatformNavBar(
    currentIndex: controller.currentBottomNavIndex,
    itemChanged: (index) {
      controller.handleBottomNavItemChanged(
        index: index,
        navigationShell: navigationShell,
      );
    },
    material3: (context, platform) {
      return MaterialNavigationBarData(
        indicatorColor: context.colors.secondaryContainer,
        labelBehavior: context.width < 600
            ? NavigationDestinationLabelBehavior.alwaysShow
            : NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: context.colors.surface,
        items: state.bottomNavItems
            .mapWithIndex(
              (index, item) => CustomNavigationDestination(
                icon:
                    item.iconWidget ??
                    item.icon.buildIconWidget(
                      color: controller.currentBottomNavIndex == index
                          ? context.colors.onSecondaryContainer
                          : context.colors.subtitleTextColor,
                    ),
                label: item.label.tr(context: context),
              ),
            )
            .toList(),
      );
    },
    cupertino: (context, _) {
      return CupertinoTabBarData(
        activeColor: context.colors.primary,
        backgroundColor: PlayxPlatform.isCupertino
            ? context.colors.surfaceContainerHigh.withValues(alpha: .7)
            : null,
        items: state.bottomNavItems
            .mapWithIndex(
              (index, item) => BottomNavigationBarItem(
                icon:
                    item.iconWidget ??
                    item.icon.buildIconWidget(
                      color: controller.currentBottomNavIndex == index
                          ? context.colors.primary
                          : context.colors.subtitleTextColor,
                      size: PlayxPlatform.isCupertino ? 20 : null,
                    ),
                label: item.label.tr(context: context),
              ),
            )
            .toList(),
      );
    },
  );
}
