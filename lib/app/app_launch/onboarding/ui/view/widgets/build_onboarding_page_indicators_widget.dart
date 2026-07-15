part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageIndicatorsWidget extends ConsumerWidget {
  const BuildOnboardingPageIndicatorsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return DotsIndicator(
      dotsCount: controller.pages.length,
      position: state.currentIndex.toDouble(),
      decorator: DotsDecorator(
        activeSize: Size(24.0.r, 12.0.h),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        activeColor: context.colors.primary,
      ),
    );
  }
}
