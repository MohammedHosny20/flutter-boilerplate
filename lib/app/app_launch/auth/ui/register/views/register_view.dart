part of '../imports/register_imports.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerControllerProvider);
    return Title(
      title: AppTrans.registerText.tr(context: context),
      color: context.colors.primary,
      child: BackButtonListener(
        onBackButtonPressed: () async {
          if (state.currentLoginMethod == LoginMethod.email) {
            ref.read(registerControllerProvider.notifier).setCurrentLoginMethod(null);
            return true;
          } else {
            return false;
          }
        },
        child: CustomScaffold(
          includeAppBar: false,
          includeLoadingOverlay: true,
          child: OptimizedScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.r,
                        horizontal: 4.r,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 16.0.r,
                                  ),
                                  child: const BuildRegisterLottieAnimation(),
                                ),
                              ),
                              const BuildRegisterBackButton(),
                            ],
                          ),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (
                                    Widget child,
                                    Animation<double> animation,
                                  ) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    );
                                  },
                              child: state.currentLoginMethod == LoginMethod.email
                                  ? const BuildRegisterWithEmailWidget()
                                  : const BuildChooseRegisterMethodWidget(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.r),
                  const BuildRegisterHaveAccountWidget(),
                  SizedBox(height: 12.r),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: AppVersion(
                      textStyle: TextStyle(
                        color: context.colors.onSurface,
                        fontSize: 12.sp,
                        fontFamily: fontFamily(context: context),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.r),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
