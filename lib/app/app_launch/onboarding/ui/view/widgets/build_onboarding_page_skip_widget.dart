part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageSkipWidget extends ConsumerWidget {
  const BuildOnboardingPageSkipWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    return CustomElevatedButton(
      width: context.width * .35,
      padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 24.w),
      onPressed: controller.handleNextOrSkip,
      label: state.isCompleted ? AppTrans.skip : AppTrans.next,
    );
  }
}
