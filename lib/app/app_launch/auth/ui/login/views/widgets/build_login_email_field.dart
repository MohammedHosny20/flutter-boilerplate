part of '../../imports/login_imports.dart';

class BuildLoginEmailFieldWidget extends ConsumerWidget {
  const BuildLoginEmailFieldWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(loginControllerProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      child: CustomTextField(
        label: AppTrans.emailOrUsernameLabel.tr(context: context),
        hint: AppTrans.emailHint.tr(context: context),
        controller: controller.emailController,
        type: TextInputType.emailAddress,
        validator: qValidator([
          IsRequired(AppTrans.emailRequired.tr(context: context)),
        ]),
        prefix: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Icon(
            Icons.email,
            color: context.colors.primary,
            size: 20.r,
          ),
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.setEmailValid(isValid);
        },
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
