part of '../imports/country_details_imports.dart';

class CountryDetailsCard extends StatelessWidget {
  final CountryUiModel country;

  const CountryDetailsCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flag
          if (country.flagUrl != null)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: ImageViewer.cachedNetwork(
                  country.flagUrl!,
                  width: 200.w,
                  height: 130.h,
                ),
              ),
            ),
          SizedBox(height: 16.h),
          // Name
          CustomText(
            country.name,
            textStyle: CustomTextStyles.title(context),
            fontSize: 24.sp,
          ),
          if (country.officialName != country.name) ...[
            SizedBox(height: 4.h),
            CustomText(
              country.officialName,
              color: context.colors.subtitleTextColor,
              fontSize: 14.sp,
            ),
          ],
          SizedBox(height: 16.h),
          // Details
          _DetailRow(
            label: AppTrans.code.tr(context: context),
            value: country.code,
          ),
          if (country.capital != null)
            _DetailRow(
              label: AppTrans.capital.tr(context: context),
              value: country.capital!,
            ),
          if (country.region != null)
            _DetailRow(
              label: AppTrans.region.tr(context: context),
              value: country.region!,
            ),
          if (country.subregion != null)
            _DetailRow(
              label: AppTrans.subregion.tr(context: context),
              value: country.subregion!,
            ),
          if (country.population != null)
            _DetailRow(
              label: AppTrans.population.tr(context: context),
              value: country.population!.toString(),
            ),
          if (country.timezones != null && country.timezones!.isNotEmpty)
            _DetailRow(
              label: AppTrans.timezones.tr(context: context),
              value: country.timezones!.join(', '),
            ),
          if (country.languages != null && country.languages!.isNotEmpty)
            _DetailRow(
              label: AppTrans.languages.tr(context: context),
              value: country.languages!
                  .map((l) => l['name'] ?? l['english_name'] ?? '')
                  .where((s) => s.toString().isNotEmpty)
                  .join(', '),
            ),
          if (country.currencies != null && country.currencies!.isNotEmpty)
            _DetailRow(
              label: AppTrans.currencies.tr(context: context),
              value: country.currencies!
                  .map((c) => c['code'] ?? c['name'] ?? '')
                  .where((s) => s.toString().isNotEmpty)
                  .join(', '),
            ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: CustomText(
              label,
              color: context.colors.subtitleTextColor,
              fontSize: 14.sp,
            ),
          ),
          Expanded(
            child: CustomText(
              value,
              color: context.colors.onSurface,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
