part of '../../imports/login_imports.dart';

class BuildLoginTitleWidget extends ConsumerWidget {
  const BuildLoginTitleWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              right: 10.w,
              left: 10.w,
              bottom: 10.h,
            ),
            width: double.infinity,
            child: CustomText(
              AppTrans.loginText.tr(context: context),
              fontSize: 40.sp,
            ),
          ),
        ),
        if (state.currentLoginMethod == LoginMethod.email)
          IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              ref.read(loginControllerProvider.notifier).setCurrentLoginMethod(null);
            },
            color: context.colors.onSurface,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
