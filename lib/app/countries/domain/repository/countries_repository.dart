import 'package:flutter_boilerplate/app/countries/data/model/models.dart';
import 'package:playx/playx.dart';

abstract class CountriesRepository {
  Future<NetworkResult<List<CountryUiModel>>> getAllCountries();
  Future<NetworkResult<List<CountryUiModel>>> searchCountries(String name);
  Future<NetworkResult<CountryUiModel>> getCountryByCode(String code);
}
