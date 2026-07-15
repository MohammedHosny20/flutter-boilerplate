part of '../imports/country_details_imports.dart';

/// Family provider that loads a single country by its code.
final countryDetailsProvider = FutureProvider.family<CountryUiModel, String>((
  ref,
  code,
) async {
  final useCase = await ref.watch(getCountryDetailsUseCaseProvider.future);
  final result = await useCase(code);
  late CountryUiModel country;
  result.when(
    success: (data) => country = data,
    error: (error) => throw Exception(error.message),
  );
  return country;
});
