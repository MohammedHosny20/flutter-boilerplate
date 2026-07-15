import 'package:flutter_boilerplate/app/countries/data/datasource/countries_remote_data_source.dart';
import 'package:flutter_boilerplate/app/countries/data/model/models.dart';
import 'package:flutter_boilerplate/app/countries/domain/repository/countries_repository.dart';
import 'package:playx/playx.dart';

class CountriesRepositoryImpl implements CountriesRepository {
  final CountriesRemoteDataSource _remoteDataSource;

  const CountriesRepositoryImpl({
    required CountriesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<NetworkResult<List<CountryUiModel>>> getAllCountries() async {
    final result = await _remoteDataSource.getAllCountries();
    return _mapListResult(result);
  }

  @override
  Future<NetworkResult<List<CountryUiModel>>> searchCountries(
    String name,
  ) async {
    final result = await _remoteDataSource.searchCountriesByName(name);
    return _mapListResult(result);
  }

  @override
  Future<NetworkResult<CountryUiModel>> getCountryByCode(String code) async {
    final result = await _remoteDataSource.getCountryByCode(code);
    return result.map(
      success: (data) => NetworkResult.success(data.data.toUi()),
      error: (error) => NetworkResult.error(error.error),
    );
  }

  NetworkResult<List<CountryUiModel>> _mapListResult(
    NetworkResult<List<CountryApiModel>> result,
  ) {
    return result.map(
      success: (data) => NetworkResult.success(data.data.toUi()),
      error: (error) => NetworkResult.error(error.error),
    );
  }
}
