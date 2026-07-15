part of '../../imports/register_imports.dart';

class BuildChooseRegisterMethodWidget extends ConsumerWidget {
  const BuildChooseRegisterMethodWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(registerControllerProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BuildRegisterSubtitleWidget(),
        ...List.generate(
          controller.loginMethods.length,
          (i) => BuildRegisterMethodButton(
            method: controller.loginMethods[i],
          ),
        ),
      ],
    );
  }
}
