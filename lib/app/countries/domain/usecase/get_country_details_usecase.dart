import 'package:flutter_boilerplate/app/countries/data/model/models.dart';
import 'package:flutter_boilerplate/app/countries/domain/repository/countries_repository.dart';
import 'package:playx/playx.dart';

class GetCountryDetailsUseCase {
  final CountriesRepository _repository;

  GetCountryDetailsUseCase(this._repository);

  Future<NetworkResult<CountryUiModel>> call(String code) {
    return _repository.getCountryByCode(code);
  }
}
