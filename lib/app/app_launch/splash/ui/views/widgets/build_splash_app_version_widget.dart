part of '../../imports/splash_imports.dart';

class BuildSplashAppVersionWidget extends ConsumerWidget {
  const BuildSplashAppVersionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(splashControllerProvider);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 30.r,
        horizontal: 10.r,
      ),
      alignment: Alignment.center,
      child: AppVersion(
        showVersionCode: state.showVersionCode,
        textStyle: TextStyle(
          fontSize: 13.sp,
          color: context.colors.primary,
          fontFamily: fontFamily(context: context),
        ),
      ),
    );
  }
}
