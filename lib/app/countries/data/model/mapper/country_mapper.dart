part of '../models.dart';

extension CountryMapper on CountryApiModel {
  CountryUiModel toUi() {
    return CountryUiModel(
      name: names.common,
      officialName: names.official ?? names.common,
      code: codes.alpha2 ?? '',
      capital: capitals?.firstWhere((c) => c.name != null).name,
      region: region,
      subregion: subregion,
      population: population,
      flagUrl: flag?.urlPng ?? flag?.urlSvg,
      languages: languages,
      currencies: currencies,
      timezones: timezones,
      callingCodes: callingCodes,
    );
  }
}

extension CountryListMapper on List<CountryApiModel> {
  List<CountryUiModel> toUi() => map((e) => e.toUi()).toList();
}
