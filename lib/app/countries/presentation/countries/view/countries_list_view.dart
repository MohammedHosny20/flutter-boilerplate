part of '../imports/countries_imports.dart';

class CountriesListView extends ConsumerStatefulWidget {
  const CountriesListView({super.key});

  @override
  ConsumerState<CountriesListView> createState() => _CountriesListViewState();
}

class _CountriesListViewState extends ConsumerState<CountriesListView> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(countriesNotifierProvider);

    return CustomScaffold(
      title: AppTrans.countries.tr(context: context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppTrans.searchCountries.tr(context: context),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(countriesNotifierProvider.notifier).searchCountries('');
                        },
                      )
                    : null,
              ),
              onSubmitted: (value) {
                ref.read(countriesNotifierProvider.notifier).searchCountries(value);
              },
            ),
          ),
          Expanded(
            child: state.when(
              loading: () => const CustomLoading(),
              error: (error, _) => CountriesErrorWidget(
                message: error.toString(),
                onRetry: () => ref.read(countriesNotifierProvider.notifier).loadCountries(),
              ),
              data: (countries) {
                if (countries.isEmpty) {
                  return EmptyDataWidget(
                    error: AppTrans.noCountriesFound.tr(context: context),
                  );
                }
                return ListView.builder(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    return CountryListItem(
                      country: country,
                      onTap: () {
                        AppNavigation.navigateToCountryDetails(code: country.code);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
