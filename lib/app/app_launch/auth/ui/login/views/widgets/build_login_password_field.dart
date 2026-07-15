part of '../../imports/login_imports.dart';

class BuildLoginPasswordFieldWidget extends ConsumerWidget {
  const BuildLoginPasswordFieldWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: CustomTextField(
        label: AppTrans.passwordLabel.tr(context: context),
        hint: AppTrans.passwordHint.tr(context: context),
        controller: controller.passwordController,
        obscureText: state.hidePassword,
        type: TextInputType.visiblePassword,
        suffix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: IconButton(
            icon: Icon(
              state.hidePassword ? Icons.visibility_off : Icons.visibility,
              size: 20.r,
            ),
            onPressed: () {
              controller.toggleHidePassword();
            },
            // color: context.colors.secondary,
          ),
        ),
        validator: qValidator([
          IsRequired(
            AppTrans.passwordRequired.tr(context: context),
          ),
          MinLength(6, AppTrans.passwordMinLengthError.tr(context: context)),
        ]),
        prefix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Icon(
            Icons.lock,
            // color: context.colors.secondary,
            size: 20.r,
          ),
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.setPasswordValid(isValid);
        },
      ),
    );
  }
}
