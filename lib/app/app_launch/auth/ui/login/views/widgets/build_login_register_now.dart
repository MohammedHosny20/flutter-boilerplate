part of '../../imports/login_imports.dart';

class BuildLoginRegisterNowWidget extends ConsumerWidget {
  const BuildLoginRegisterNowWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: InkWell(
        onTap: ref.read(loginControllerProvider.notifier).navigateToRegister,
        child: RichText(
          text: TextSpan(
            text: AppTrans.dontHaveAccountText.tr(context: context),
            style: TextStyle(
              color: context.colors.onSurface,
              fontSize: 14.sp,
              fontFamily: fontFamily(context: context),
            ),
            children: <TextSpan>[
              TextSpan(
                text: AppTrans.registerNow.tr(context: context),
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 14.sp,
                  fontFamily: fontFamily(context: context),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
