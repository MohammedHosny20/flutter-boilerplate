part of '../../imports/login_view_imports.dart';

class BuildLoginButton extends ConsumerWidget {
  const BuildLoginButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otpLoginControllerProvider);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.h,
      ),
      child: CustomElevatedButton(
        label: AppTrans.loginText.tr(context: context),
        onPressed: state.isPhoneNumberValid
            ? ref.read(otpLoginControllerProvider.notifier).login
            : null,
        isLoading: state.isLoading,
      ),
    );
  }
}
