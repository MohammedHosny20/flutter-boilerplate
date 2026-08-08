part of '../../network.dart';

enum ApiKeys { products, data }

extension ApiKeysExtension on ApiKeys {
  String get key {
    switch (this) {
      case ApiKeys.products:
        return 'products';
      case ApiKeys.data:
        return 'data';
    }
  }
}
