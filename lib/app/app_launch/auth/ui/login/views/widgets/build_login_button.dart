part of '../../imports/login_imports.dart';

class BuildLoginButtonWidget extends ConsumerWidget {
  const BuildLoginButtonWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    return CustomElevatedButton(
      onPressed: state.isFormValid ? ref.read(loginControllerProvider.notifier).login : null,
      label: AppTrans.loginText,
    );
  }
}
