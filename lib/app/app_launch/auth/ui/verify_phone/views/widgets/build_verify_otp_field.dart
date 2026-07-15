part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyOtpField extends ConsumerWidget {
  const BuildVerifyOtpField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verifyPhoneControllerProvider);
    final controller = ref.read(verifyPhoneControllerProvider.notifier);
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          keyboardAppearance: Brightness.dark,
          keyboardType: TextInputType.phone,
          closeKeyboardWhenCompleted: false,
          autofocus: true,
          validator: (s) {
            final isValid = controller.isOtpCodeValidNumber(s ?? '');
            controller.setOtpValid(isValid);
            return isValid ? null : AppTrans.verifyPhoneValidOtpError.tr(context: context);
          },
          onTap: () {
            controller.setShowScrollPadding(true);
          },
          onChanged: controller.handleOtpPinChanged,
          onCompleted: (pin) => controller.verifyOtp(),
          scrollPadding: EdgeInsets.all(
            state.showScrollPadding ? context.height * .3 : 0,
          ),
        ),
      ),
    );
  }
}
