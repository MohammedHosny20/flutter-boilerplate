import 'package:flutter_boilerplate/app/products/domain/domain.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/src/use_case.dart';

class SearchProductsUseCase
    extends UseCaseWithParams<DataWrapper<List<Product>>, ProductsParams> {
  final ProductsRepository _repository;

  const SearchProductsUseCase(this._repository);

  @override
  ResultFuture<DataWrapper<List<Product>>> call(ProductsParams params) {
    final trimmed = params.query.trim();
    if (trimmed.isEmpty) {
      return _repository.getProducts(params: params);
    }
    return _repository.searchProducts(
      params: ProductsParams(
        query: trimmed,
        page: params.page,
        pageSize: params.pageSize,
        cancelToken: params.cancelToken,
      ),
    );
  }
}
