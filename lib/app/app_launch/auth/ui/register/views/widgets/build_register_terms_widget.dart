part of '../../imports/register_imports.dart';

class BuildRegisterTermsWidget extends ConsumerWidget {
  const BuildRegisterTermsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.r,
        vertical: 4.r,
      ),
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            height: 24.r,
            width: 24.r,
            child: Checkbox(
              value: state.agreeToTerms,
              onChanged: (value) {
                controller.setAgreeToTerms(value ?? false);
              },
              activeColor: context.colors.onSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(width: 4.r),
          CustomText(
            AppTrans.agreeToTerms,
            fontSize: 14.sp,
            color: context.colors.onSurface,
            fontWeight: FontWeight.w400,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
