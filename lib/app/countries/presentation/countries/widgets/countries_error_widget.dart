part of '../imports/countries_imports.dart';

class CountriesErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CountriesErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60.r,
              color: context.colors.error,
            ),
            SizedBox(height: 16.h),
            CustomText(
              message,
              textAlign: TextAlign.center,
              color: context.colors.onSurface,
              fontSize: 14.sp,
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              onPressed: onRetry,
              label: AppTrans.retryText.tr(context: context),
            ),
          ],
        ),
      ),
    );
  }
}
