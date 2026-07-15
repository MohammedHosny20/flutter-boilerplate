part of '../../ui.dart';

class MenuIconButton extends ConsumerWidget {
  const MenuIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appController = ref.read(appControllerProvider.notifier);
    return IconButton(
      onPressed: () {
        appController.toggleDrawer();
      },
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: appController.drawerController,
        builder: (_, value, _) {
          return AnimatedRotation(
            turns: value.visible ? (context.isRtl ? 0 : .5) : (context.isRtl ? .5 : 0),
            duration: const Duration(milliseconds: 200),
            child: ImageViewer.svgAsset(
              Assets.icons.expand,
              color: context.colors.onAppBar,
              width: context.isTablet ? 20.r : 24,
              height: context.isTablet ? 20.r : 24,
            ),
          );
        },
      ),
    );
  }
}
