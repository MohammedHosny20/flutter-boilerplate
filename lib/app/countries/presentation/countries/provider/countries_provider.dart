part of '../imports/countries_imports.dart';

/// Provider for [CountriesRemoteDataSource].
final countriesRemoteDataSourceProvider = FutureProvider<CountriesRemoteDataSource>((
  ref,
) async {
  final client = await ref.watch(restCountriesClientProvider.future);
  return CountriesRemoteDataSource(client: client);
});

/// Provider for [CountriesRepository].
final countriesRepositoryProvider = FutureProvider<CountriesRepository>((ref) async {
  final dataSource = await ref.watch(countriesRemoteDataSourceProvider.future);
  return CountriesRepositoryImpl(remoteDataSource: dataSource);
});

/// Provider for [GetCountriesUseCase].
final getCountriesUseCaseProvider = FutureProvider<GetCountriesUseCase>((ref) async {
  final repo = await ref.watch(countriesRepositoryProvider.future);
  return GetCountriesUseCase(repo);
});

/// Provider for [GetCountryDetailsUseCase].
final getCountryDetailsUseCaseProvider = FutureProvider<GetCountryDetailsUseCase>((ref) async {
  final repo = await ref.watch(countriesRepositoryProvider.future);
  return GetCountryDetailsUseCase(repo);
});
