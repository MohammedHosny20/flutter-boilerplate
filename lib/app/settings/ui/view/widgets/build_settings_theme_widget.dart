part of '../../imports/settings_imports.dart';

class BuildSettingsThemeWidget extends ConsumerWidget {
  const BuildSettingsThemeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return BuildSettingsTile(
      title: AppTrans.theme,
      subtitle: state.currentTheme.name,
      icon: Icons.dark_mode_rounded,
      onTap: () {
        controller.showSettingsModalPageSheet(
          context,
          buildModalPage(ref: ref, context: context),
        );
      },
    );
  }

  static SliverWoltModalSheetPage buildModalPage({
    required WidgetRef ref,
    required BuildContext context,
    bool isOnlyPage = true,
  }) {
    final state = ref.read(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    return BuildSettingsPage.buildModalPage(
      title: AppTrans.theme,
      items: PlayxTheme.supportedThemes,
      onItemSelected: (theme) => controller.handleThemeSelection(theme, context: context),
      itemName: (theme) => theme.name.tr(context: context),
      isItemSelected: (theme) => state.currentTheme.id == theme.id,
      onCloseButtonPressed: controller.closeSettingsModalSheet,
      onBackButtonPressed: isOnlyPage
          ? null
          : () {
              ref.read(settingsControllerProvider.notifier).closeSettingsModalSheet();
            },
      context: context,
      showPreviousButton: !isOnlyPage,
    );
  }
}
