part of '../../imports/register_imports.dart';

class BuildRegisterPasswordFieldWidget extends ConsumerWidget {
  const BuildRegisterPasswordFieldWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    final controller = ref.read(registerControllerProvider.notifier);
    return BuildRegisterFieldWidget(
      label: AppTrans.passwordLabel,
      textField: CustomTextField(
        hint: AppTrans.passwordHint,
        controller: controller.passwordController,
        obscureText: state.hidePassword,
        type: TextInputType.visiblePassword,
        suffix: IconButton(
          icon: Icon(
            state.hidePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: controller.changeHidePasswordState,
          // color: context.colors.secondary,
        ),
        validator: qValidator([
          IsRequired(
            AppTrans.passwordRequired.tr(context: context),
          ),
          MinLength(
            6,
            AppTrans.passwordMinLengthError.tr(context: context),
          ),
        ]),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14.r,
          vertical: 10.r,
        ),
        prefix: Icon(
          Icons.lock,
          color: context.colors.onSurface,
          size: 18.r,
        ),
        onChanged: (text) {
          if (controller.confirmPasswordController.value.text.isNotEmpty) {
            final formState = controller.confirmPasswordFormKey.currentState;
            final isValid = formState != null && formState.validate();
            controller.setConfirmPasswordValid(isValid);
          }
        },
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.setPasswordValid(isValid);
        },
        textInputAction: TextInputAction.next,
        focus: controller.passwordFocus,
        nextFocus: controller.confirmPasswordFocus,
      ),
    );
  }
}
