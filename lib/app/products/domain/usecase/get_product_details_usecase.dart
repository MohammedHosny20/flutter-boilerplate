import 'package:flutter_boilerplate/app/products/domain/domain.dart';
import 'package:flutter_boilerplate/core/base/base_usecase.dart';

class GetProductDetailsUseCase extends UseCaseWithParams<Product, int> {
  final ProductsRepository _repository;

  const GetProductDetailsUseCase(this._repository);

  @override
  ResultFuture<Product> call(int id) {
    return _repository.getProductById(id);
  }
}
