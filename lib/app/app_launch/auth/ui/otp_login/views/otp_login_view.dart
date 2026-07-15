part of '../imports/login_view_imports.dart';

// login screen widget.
class OtpLoginView extends ConsumerWidget {
  const OtpLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PlatformScaffold(
      body: SafeArea(
        child: OptimizedScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildLoginLottieAnimation(),
              BuildLoginText(),
              BuildLoginSubtitleText(),
              BuildMobileLoginTextField(),
              BuildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
