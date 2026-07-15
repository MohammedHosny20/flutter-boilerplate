part of '../../imports/register_imports.dart';

class BuildRegisterButtonWidget extends ConsumerWidget {
  const BuildRegisterButtonWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    return CustomElevatedButton(
      onPressed: state.isFormValid ? ref.read(registerControllerProvider.notifier).register : null,
      padding: EdgeInsets.symmetric(
        vertical: 17.r,
        horizontal: 8.r,
      ),
      child: CustomText(
        AppTrans.registerText,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: state.isFormValid ? context.colors.onPrimary : context.colors.subtitleTextColor,
      ),
    );
  }
}
