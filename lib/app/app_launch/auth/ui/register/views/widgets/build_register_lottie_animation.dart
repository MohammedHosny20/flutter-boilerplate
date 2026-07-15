part of '../../imports/register_imports.dart';

class BuildRegisterLottieAnimation extends ConsumerWidget {
  const BuildRegisterLottieAnimation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: state.currentLoginMethod == LoginMethod.email
              ? EdgeInsets.only(
                  top: 16.0.r,
                  bottom: 8.r,
                  right: 8.0.r,
                  left: 8.r,
                )
              : EdgeInsets.only(
                  top: 60.0.r,
                  bottom: 8.r,
                  right: 8.0.r,
                  left: 8.r,
                ),
          child: CircleAvatar(
            radius: state.currentLoginMethod == LoginMethod.email
                ? context.height * .05
                : context.height * .07,
            backgroundColor: context.colors.surface,
            child: ImageViewer.svgAsset(
              Assets.icons.logo,
              width: state.currentLoginMethod == LoginMethod.email
                  ? context.height * .1
                  : context.height * .25,
              height: state.currentLoginMethod == LoginMethod.email
                  ? context.height * .1
                  : context.height * .25,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
