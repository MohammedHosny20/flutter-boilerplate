part of '../../imports/register_imports.dart';

class BuildRegisterNameFieldWidget extends ConsumerWidget {
  const BuildRegisterNameFieldWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(registerControllerProvider.notifier);
    return Row(
      children: [
        Expanded(
          child: BuildRegisterFieldWidget(
            label: AppTrans.firstNameLabel,
            textField: CustomTextField(
              hint: AppTrans.firstNameHint,
              hintStyle: TextStyle(
                color: context.colors.subtitleTextColor,
                fontFamily: fontFamily(context: context),
                fontSize: 12.sp,
              ),
              controller: controller.firstNameController,
              type: TextInputType.name,
              validator: qValidator([
                IsRequired(AppTrans.firstNameRequired.tr(context: context)),
              ]),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.r,
                vertical: 10.r,
              ),
              prefix: Icon(
                Icons.person,
                size: 18.r,
                color: context.colors.onSurface,
              ),
              shouldAutoValidate: true,
              onValidationChanged: (isValid) {
                controller.setFirstNameValid(isValid);
              },
              textInputAction: TextInputAction.next,
              focus: controller.firstNameFocus,
              nextFocus: controller.lastNameFocus,
            ),
          ),
        ),
        Expanded(
          child: BuildRegisterFieldWidget(
            label: AppTrans.lastNameLabel,
            textField: CustomTextField(
              hint: AppTrans.lastNameHint,
              controller: controller.lastNameController,
              hintStyle: TextStyle(
                color: context.colors.subtitleTextColor,
                fontFamily: fontFamily(context: context),
                fontSize: 12.sp,
              ),
              type: TextInputType.name,
              validator: qValidator([
                IsRequired(AppTrans.lastNameRequired.tr(context: context)),
              ]),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.r,
                vertical: 10.r,
              ),
              prefix: Icon(
                Icons.person,
                size: 18.r,
                color: context.colors.onSurface,
              ),
              shouldAutoValidate: true,
              onValidationChanged: (isValid) {
                controller.setLastNameValid(isValid);
              },
              textInputAction: TextInputAction.next,
              focus: controller.lastNameFocus,
              nextFocus: controller.emailFocus,
            ),
          ),
        ),
      ],
    );
  }
}
