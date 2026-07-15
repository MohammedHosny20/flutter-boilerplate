import 'package:flutter_boilerplate/app/countries/data/model/models.dart';
import 'package:flutter_boilerplate/app/countries/domain/repository/countries_repository.dart';
import 'package:playx/playx.dart';

class GetCountriesUseCase {
  final CountriesRepository _repository;

  GetCountriesUseCase(this._repository);

  Future<NetworkResult<List<CountryUiModel>>> call() {
    return _repository.getAllCountries();
  }
}
