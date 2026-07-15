// ignore_for_file: avoid_dynamic_calls

part of '../models.dart';

/// Country network DTO returned by the countries API.
class CountryApiModel {
  final CountryNameApiModel names;
  final CountryCodesApiModel codes;
  final List<CapitalApiModel>? capitals;
  final String? region;
  final String? subregion;
  final int? population;
  final CountryFlagApiModel? flag;
  final List<Map<String, dynamic>>? languages;
  final List<Map<String, dynamic>>? currencies;
  final List<String>? timezones;
  final List<String>? callingCodes;

  const CountryApiModel({
    required this.names,
    required this.codes,
    this.capitals,
    this.region,
    this.subregion,
    this.population,
    this.flag,
    this.languages,
    this.currencies,
    this.timezones,
    this.callingCodes,
  });

  factory CountryApiModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return CountryApiModel(
      names: CountryNameApiModel.fromJson(asMap(map, 'names')),
      codes: CountryCodesApiModel.fromJson(asMap(map, 'codes')),
      capitals: asListOrNull<CapitalApiModel>(map, 'capitals', fromJson: CapitalApiModel.fromJson),
      region: asStringOrNull(map, 'region'),
      subregion: asStringOrNull(map, 'subregion'),
      population: asIntOrNull(map, 'population'),
      flag: map['flag'] == null ? null : CountryFlagApiModel.fromJson(asMap(map, 'flag')),
      languages: _asMapListOrNull(map['languages']),
      currencies: _asMapListOrNull(map['currencies']),
      timezones: asListStringOrNull(map, 'timezones'),
      callingCodes: asListStringOrNull(map, 'calling_codes'),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'names': names.toJson(),
      'codes': codes.toJson(),
      if (capitals != null) 'capitals': capitals!.map((e) => e.toJson()).toList(),
      if (region != null) 'region': region,
      if (subregion != null) 'subregion': subregion,
      if (population != null) 'population': population,
      if (flag != null) 'flag': flag!.toJson(),
      if (languages != null) 'languages': languages,
      if (currencies != null) 'currencies': currencies,
      if (timezones != null) 'timezones': timezones,
      if (callingCodes != null) 'calling_codes': callingCodes,
    };
    return map;
  }
}

class CountryNameApiModel {
  final String common;
  final String? official;

  const CountryNameApiModel({
    required this.common,
    this.official,
  });

  factory CountryNameApiModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return CountryNameApiModel(
      common: asString(map, 'common'),
      official: asStringOrNull(map, 'official'),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'common': common};
    if (official != null) map['official'] = official;
    return map;
  }
}

class CountryCodesApiModel {
  final String? alpha2;
  final String? alpha3;
  final String? ccn3;

  const CountryCodesApiModel({
    this.alpha2,
    this.alpha3,
    this.ccn3,
  });

  factory CountryCodesApiModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return CountryCodesApiModel(
      alpha2: asStringOrNull(map, 'alpha_2'),
      alpha3: asStringOrNull(map, 'alpha_3'),
      ccn3: asStringOrNull(map, 'ccn3'),
    );
  }

  Map<String, dynamic> toJson() => {
    if (alpha2 != null) 'alpha_2': alpha2,
    if (alpha3 != null) 'alpha_3': alpha3,
    if (ccn3 != null) 'ccn3': ccn3,
  };
}

class CapitalApiModel {
  final String? name;

  const CapitalApiModel({
    this.name,
  });

  factory CapitalApiModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return CapitalApiModel(name: asStringOrNull(map, 'name'));
  }

  Map<String, dynamic> toJson() => {
    if (name != null) 'name': name,
  };
}

class CountryFlagApiModel {
  final String? emoji;
  final String? urlPng;
  final String? urlSvg;
  final String? description;

  const CountryFlagApiModel({
    this.emoji,
    this.urlPng,
    this.urlSvg,
    this.description,
  });

  factory CountryFlagApiModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return CountryFlagApiModel(
      emoji: asStringOrNull(map, 'emoji'),
      urlPng: asStringOrNull(map, 'url_png'),
      urlSvg: asStringOrNull(map, 'url_svg'),
      description: asStringOrNull(map, 'description'),
    );
  }

  Map<String, dynamic> toJson() => {
    if (emoji != null) 'emoji': emoji,
    if (urlPng != null) 'url_png': urlPng,
    if (urlSvg != null) 'url_svg': urlSvg,
    if (description != null) 'description': description,
  };
}

/// Safely converts a JSON value into a `List<Map<String, dynamic>>?`.
///
/// Handles both `List<Map<String, dynamic>>` (already typed) and
/// `List<dynamic>` containing `Map<String, dynamic>` items, returning `null`
/// when the value is not a list or any element is not a map.
List<Map<String, dynamic>>? _asMapListOrNull(dynamic value) {
  if (value == null) return null;
  if (value is List<Map<String, dynamic>>) return value;
  if (value is List) {
    final result = <Map<String, dynamic>>[];
    for (final item in value) {
      if (item is Map<String, dynamic>) {
        result.add(item);
      } else if (item is Map) {
        result.add(Map<String, dynamic>.from(item));
      } else {
        return null;
      }
    }
    return result;
  }
  return null;
}
