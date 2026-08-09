import 'package:flutter_boilerplate/app/products/domain/domain.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/src/use_case.dart';
import 'package:playx/playx.dart' hide ResultFuture;

class GetProductsUseCase
    extends UseCaseWithParams<DataWrapper<List<Product>>, ProductsParams> {
  final ProductsRepository _repository;

  const GetProductsUseCase(this._repository);

  @override
  ResultFuture<DataWrapper<List<Product>>> call(ProductsParams params) {
    return _repository.getProducts(params: params);
  }
}

class ProductsParams extends Equatable {
  final String query;
  final int page;
  final int pageSize;
  final CancelToken? cancelToken;

  const ProductsParams({
    this.query = '',
    this.page = 1,
    this.pageSize = 20,
    this.cancelToken,
  });

  @override
  List<Object?> get props => [query, page, pageSize, cancelToken];
}
