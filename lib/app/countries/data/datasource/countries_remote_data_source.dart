import 'package:flutter_boilerplate/app/countries/data/model/models.dart';
import 'package:playx/playx.dart';

class CountriesRemoteDataSource {
  final PlayxNetworkClient _client;

  const CountriesRemoteDataSource({required PlayxNetworkClient client}) : _client = client;

  Future<NetworkResult<List<CountryApiModel>>> getAllCountries() async {
    final result = await _client.getList(
      '',
      query: {'limit': '100'},
      dataKey: 'data.objects',
      fromJson: (json) => CountryApiModel.fromJson(json as Map<String, dynamic>),
    );
    return result;
  }

  Future<NetworkResult<List<CountryApiModel>>> searchCountriesByName(
    String name,
  ) async {
    final result = await _client.getList(
      '/name',
      query: {'q': name},
      dataKey: 'data.objects',
      fromJson: (json) => CountryApiModel.fromJson(json as Map<String, dynamic>),
    );
    return result;
  }

  Future<NetworkResult<CountryApiModel>> getCountryByCode(String code) async {
    final result = await _client.getList(
      '/codes.alpha_2/$code',
      dataKey: 'data.objects',
      fromJson: (json) => CountryApiModel.fromJson(json as Map<String, dynamic>),
    );
    return result.map(
      success: (s) => NetworkResult.success(s.data.first),
      error: (e) => NetworkResult.error(e.error),
    );
  }
}
