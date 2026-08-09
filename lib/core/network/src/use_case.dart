import 'package:flutter_boilerplate/core/network/src/result_types.dart';

export 'package:flutter_boilerplate/core/network/src/result_types.dart';

/// Use case that requires input [Params].
abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

/// Use case with no input parameters.
abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
