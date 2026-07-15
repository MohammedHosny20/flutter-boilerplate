part of '../imports/country_details_imports.dart';

/// Notifier that manages loading and retrying a single country's details by its code.
class CountryDetailsNotifier extends AsyncNotifier<CountryUiModel> {
  CountryDetailsNotifier(this.code);

  final String code;

  @override
  FutureOr<CountryUiModel> build() {
    return loadCountryDetails();
  }

  Future<CountryUiModel> loadCountryDetails() async {
    state = const AsyncValue.loading();
    try {
      final useCase = await ref.read(getCountryDetailsUseCaseProvider.future);
      final result = await useCase(code);
      late CountryUiModel country;
      result.when(
        success: (data) => country = data,
        error: (error) => throw Exception(error.message),
      );
      state = AsyncValue.data(country);
      return country;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      rethrow;
    }
  }

  Future<void> retry() async {
    await loadCountryDetails();
  }
}

/// Family provider for [CountryDetailsNotifier] keyed by country code.
final countryDetailsProvider =
    AsyncNotifierProvider.family<CountryDetailsNotifier, CountryUiModel, String>(
      CountryDetailsNotifier.new,
    );
