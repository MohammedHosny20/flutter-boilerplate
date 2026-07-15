part of '../imports/countries_imports.dart';

class CountryListItem extends StatelessWidget {
  final CountryUiModel country;
  final VoidCallback onTap;

  const CountryListItem({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomCard(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Row(
            children: [
              if (country.flagUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: ImageViewer.cachedNetwork(
                    country.flagUrl!,
                    width: 50.w,
                    height: 35.h,
                  ),
                )
              else
                Container(
                  width: 50.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: context.colors.primaryContainer,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.flag, color: context.colors.onPrimaryContainer),
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      country.name,
                      textStyle: CustomTextStyles.title(context),
                      color: context.colors.onSurface,
                    ),
                    if (country.capital != null)
                      CustomText(
                        '${AppTrans.capital.tr(context: context)}: ${country.capital}',
                        color: context.colors.subtitleTextColor,
                        fontSize: 13.sp,
                      ),
                    if (country.region != null)
                      CustomText(
                        '${AppTrans.region.tr(context: context)}: ${country.region}',
                        color: context.colors.subtitleTextColor,
                        fontSize: 13.sp,
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: context.colors.subtitleTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
