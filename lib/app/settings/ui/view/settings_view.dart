part of '../imports/settings_imports.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlayxThemeSwitchingArea(
      child: CustomScaffold(
        title: AppTrans.settings,
        backgroundColor: context.colors.surface,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 8.0.r),
                  const BuildSettingsLanguageWidget(),
                  const BuildSettingsThemeWidget(),
                  const BuildSettingsLogOutWidget(),
                  SizedBox(height: 16.0.r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static SliverWoltModalSheetPage buildSettingsModalSheetPage(
    Ref ref,
    BuildContext context,
  ) {
    return CustomModal.buildCustomModalPage(
      title: AppTrans.settings,
      body: const SettingsView(),
      onClosePressed: () => ref.read(settingsControllerProvider.notifier).closeSettingsModalSheet,
      context: context,
    );
  }
}
