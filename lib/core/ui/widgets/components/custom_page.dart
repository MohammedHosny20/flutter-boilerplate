part of '../../ui.dart';

class CustomPageScaffold extends ConsumerWidget {
  final StatefulNavigationShell? navigationShell;
  final Widget? child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final bool canShowDrawer;
  final bool disabledGestures;

  /// Decides whether to show bottom navigation bar or not
  final bool showBottomNav;

  final GoRouterState state;

  const CustomPageScaffold({
    super.key,
    this.child,
    this.title,
    this.padding,
    this.appBar,
    this.canShowDrawer = true,
    this.disabledGestures = true,
    this.showBottomNav = false,
    required this.state,
  }) : navigationShell = null;

  const CustomPageScaffold.navigationShell({
    super.key,
    required this.navigationShell,
    this.title,
    this.padding,
    this.appBar,
    this.canShowDrawer = true,
    this.disabledGestures = true,
    this.showBottomNav = false,
    required this.state,
  }) : child = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appControllerProvider);
    final appController = ref.read(appControllerProvider.notifier);

    final scaffoldChild = PlatformScaffold(
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          navigationShell ?? child ?? const SizedBox.shrink(),
          LoadingOverlay(
            loadingStatus: appController.loadingStatus.value,
          ),
        ],
      ),
    );

    return navigationShell != null && canShowDrawer
        ? CustomDrawer(
            navigationShell: navigationShell!,
            disabledGestures: appState.disableDrawerGestures || disabledGestures,
            child: scaffoldChild,
          )
        : scaffoldChild;
  }

  static Page<dynamic> buildNavigationShellPage({
    required GoRouterState state,
    required StatefulNavigationShell navigationShell,
    bool canShowDrawer = true,
    bool disabledGestures = true,
    bool showBottomNav = true,
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold.navigationShell(
            navigationShell: navigationShell,
            canShowDrawer: canShowDrawer,
            showBottomNav: showBottomNav,
            disabledGestures: disabledGestures,
            state: state,
          );
        },
      ),
      key: state.pageKey,
      name: state.name,
    );
  }

  static Page<dynamic> buildPage({
    required GoRouterState state,
    required Widget child,
    bool showBottomNav = true,
    bool canShowDrawer = true,
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold(
            canShowDrawer: canShowDrawer,
            showBottomNav: showBottomNav,
            state: state,
            child: child,
          );
        },
      ),
      key: state.pageKey,
      name: state.name,
    );
  }
}
