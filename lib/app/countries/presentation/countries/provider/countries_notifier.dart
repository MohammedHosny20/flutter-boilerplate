part of '../imports/countries_imports.dart';

class CountriesNotifier extends Notifier<AsyncValue<List<CountryUiModel>>> {
  @override
  AsyncValue<List<CountryUiModel>> build() {
    Future.microtask(() => loadCountries());
    return const AsyncValue.loading();
  }

  Future<void> loadCountries() async {
    state = const AsyncValue.loading();
    try {
      final useCase = await ref.read(getCountriesUseCaseProvider.future);
      final result = await useCase();
      result.when(
        success: (countries) {
          state = AsyncValue.data(countries);
        },
        error: (error) {
          state = AsyncValue.error(error.message, StackTrace.current);
        },
      );
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> searchCountries(String query) async {
    if (query.isEmpty) {
      return clearSearch();
    }
    state = const AsyncValue.loading();
    try {
      final repo = await ref.read(countriesRepositoryProvider.future);
      final result = await repo.searchCountries(query);
      result.when(
        success: (countries) {
          state = AsyncValue.data(countries);
        },
        error: (error) {
          state = AsyncValue.error(error.message, StackTrace.current);
        },
      );
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> clearSearch() async {
    await loadCountries();
  }
}

final countriesNotifierProvider =
    NotifierProvider<CountriesNotifier, AsyncValue<List<CountryUiModel>>>(CountriesNotifier.new);
