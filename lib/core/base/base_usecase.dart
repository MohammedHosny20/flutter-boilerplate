import 'package:flutter_boilerplate/core/base/base_repository.dart';

export 'package:flutter_boilerplate/core/base/base_repository.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  ResultFuture<T> call();
}
