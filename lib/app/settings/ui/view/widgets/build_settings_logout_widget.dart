part of '../../imports/settings_imports.dart';

class BuildSettingsLogOutWidget extends ConsumerWidget {
  const BuildSettingsLogOutWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsControllerProvider.notifier);
    return BuildSettingsTile(
      title: AppTrans.logout,
      icon: Icons.logout,
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.0.h),
      onTap: controller.handleLogOutTap,
    );
  }
}
