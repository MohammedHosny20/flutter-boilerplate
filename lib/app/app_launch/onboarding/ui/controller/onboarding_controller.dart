part of '../imports/onboarding_imports.dart';

class OnBoardingState {
  final int currentIndex;
  final bool isCompleted;

  OnBoardingState({this.currentIndex = 0, this.isCompleted = false});

  OnBoardingState copyWith({int? currentIndex, bool? isCompleted}) {
    return OnBoardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class OnBoardingController extends Notifier<OnBoardingState> {
  final pageController = PageController();

  final pages = <OnBoarding>[
    OnBoarding(
      title: AppTrans.firstBoardingTitle,
      subtitle: AppTrans.firstBoardingSubTitle,
      lottieAsset: Assets.animations.firstBoardingAnimation,
    ),
    OnBoarding(
      title: AppTrans.secondBoardingTitle,
      subtitle: AppTrans.secondBoardingSubTitle,
      lottieAsset: Assets.animations.secondBoardingAnimation,
    ),
    OnBoarding(
      title: AppTrans.thirdBoardingTitle,
      subtitle: AppTrans.thirdBoardingSubTitle,
      lottieAsset: Assets.animations.thirdBoardingAnimation,
    ),
  ];

  @override
  OnBoardingState build() {
    return OnBoardingState();
  }

  Future<void> handleNextOrSkip() async {
    if (state.isCompleted) {
      MyPreferenceManger.instance.saveOnBoardingShown();
      AppNavigation.navigateFromOnBoardingToLogin();
    } else {
      pageController.animateToPage(
        state.currentIndex + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int value) {
    state = state.copyWith(
      currentIndex: value,
      isCompleted: value == pages.length - 1,
    );
  }
}

final onboardingControllerProvider = NotifierProvider<OnBoardingController, OnBoardingState>(
  OnBoardingController.new,
);
