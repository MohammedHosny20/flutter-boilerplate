part of '../models.dart';

/// Domain/UI representation of a country, mapped from [CountryApiModel].
class CountryUiModel {
  final String name;
  final String officialName;
  final String code;
  final String? capital;
  final String? region;
  final String? subregion;
  final int? population;
  final String? flagUrl;
  final List<Map<String, dynamic>>? languages;
  final List<Map<String, dynamic>>? currencies;
  final List<String>? timezones;
  final List<String>? callingCodes;

  const CountryUiModel({
    required this.name,
    required this.officialName,
    required this.code,
    this.capital,
    this.region,
    this.subregion,
    this.population,
    this.flagUrl,
    this.languages,
    this.currencies,
    this.timezones,
    this.callingCodes,
  });
}
