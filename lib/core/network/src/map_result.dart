import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:flutter_boilerplate/core/network/src/result_types.dart';
import 'package:playx/playx.dart' hide ResultFuture;

export 'package:flutter_boilerplate/core/network/src/result_types.dart';

/// Maps a Playx [NetworkResult] from the data source into a domain [NetworkResult].
///
/// ```dart
/// return execute(
///   () => _dataSource.getProducts(params: params),
///   mapper: (data) => DataWrapper(data: data.toEntity()),
/// );
/// ```
///
/// When DTO and domain types match, use `mapper: (data) => data`.
ResultFuture<R> execute<T, R>(
  Future<NetworkResult<T>> Function() fun, {
  required R Function(T data) mapper,
}) async {
  try {
    final result = await fun();
    return result.map(
      success: (success) => NetworkResult.success(mapper(success.data)),
      error: (error) => NetworkResult.error(error.error),
    );
  } catch (error) {
    myLogger.d('error in execute ===> $error');
    if (error is NetworkException) {
      return NetworkResult.error(error);
    }
    return NetworkResult.error(
      UnexpectedErrorException(errorMessage: '$error'),
    );
  }
}
