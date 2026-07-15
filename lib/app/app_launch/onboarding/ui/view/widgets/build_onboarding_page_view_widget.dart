part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageViewWidget extends ConsumerWidget {
  const BuildOnboardingPageViewWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onboardingControllerProvider.notifier);
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: List.generate(
        controller.pages.length,
        (index) => OnBoardingPage(onboarding: controller.pages[index]),
      ),
    );
  }
}
