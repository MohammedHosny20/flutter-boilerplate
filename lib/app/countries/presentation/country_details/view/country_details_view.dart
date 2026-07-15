part of '../imports/country_details_imports.dart';

class CountryDetailsView extends ConsumerWidget {
  final String code;

  const CountryDetailsView({super.key, required this.code});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCountry = ref.watch(countryDetailsProvider(code));

    return CustomScaffold(
      title: AppTrans.countryDetails.tr(context: context),
      child: asyncCountry.when(
        loading: () => const CustomLoading(),
        error: (error, _) => CountriesErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(countryDetailsProvider(code)),
        ),
        data: (country) => CountryDetailsCard(country: country),
      ),
    );
  }
}
