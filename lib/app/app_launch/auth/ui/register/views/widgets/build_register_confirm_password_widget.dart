part of '../../imports/register_imports.dart';

class BuildRegisterConfirmPasswordWidget extends ConsumerWidget {
  const BuildRegisterConfirmPasswordWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    return BuildRegisterFieldWidget(
      label: AppTrans.confirmPasswordLabel,
      textField: CustomTextField(
        hint: AppTrans.confirmPasswordHint,
        controller: controller.confirmPasswordController,
        obscureText: state.hideConfirmPassword,
        type: TextInputType.visiblePassword,
        suffix: IconButton(
          icon: Icon(
            state.hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: controller.changeHideConfirmPasswordState,
          // color: context.colors.secondary,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.r,
          vertical: 10.r,
        ),
        validator: qValidator([
          IsRequired(
            AppTrans.passwordRequired.tr(context: context),
          ),
          AreEqual(
            other: () => controller.passwordController.value.text,
            errorMsg: AppTrans.confirmPasswordMatchError.tr(context: context),
          ),
        ]),
        prefix: Icon(
          Icons.lock,
          color: context.colors.onSurface,
          size: 18.r,
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.setConfirmPasswordValid(isValid);
        },
        focus: controller.confirmPasswordFocus,
      ),
    );
  }
}
