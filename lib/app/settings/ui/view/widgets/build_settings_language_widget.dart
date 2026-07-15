part of '../../imports/settings_imports.dart';

class BuildSettingsLanguageWidget extends ConsumerWidget {
  const BuildSettingsLanguageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return BuildSettingsTile(
      title: AppTrans.language,
      subtitle: state.currentLocale?.name ?? '',
      icon: Icons.language,
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
      title: AppTrans.language,
      items: controller.supportedLocales,
      onItemSelected: (lang) => controller.handleLanguageSelection(lang),
      itemName: (lang) => lang.name,
      isItemSelected: (lang) => state.currentLocale == lang,
      onBackButtonPressed: isOnlyPage
          ? null
          : () {
              ref.read(settingsControllerProvider.notifier).closeSettingsModalSheet();
            },
      showPreviousButton: !isOnlyPage,
      onCloseButtonPressed: controller.closeSettingsModalSheet,
      context: context,
    );
  }
}
