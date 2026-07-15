part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyButton extends ConsumerWidget {
  const BuildVerifyButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verifyPhoneControllerProvider);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: CustomElevatedButton(
        label: AppTrans.verifyPhoneBtnText,
        onPressed: state.isOtpValid
            ? ref.read(verifyPhoneControllerProvider.notifier).verifyOtp
            : null,
        isLoading: state.isLoading,
      ),
    );
  }
}
