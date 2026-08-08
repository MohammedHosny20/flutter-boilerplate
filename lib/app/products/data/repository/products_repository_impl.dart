import 'package:flutter_boilerplate/app/products/data/data.dart';
import 'package:flutter_boilerplate/core/base/base_repository.dart';
import 'package:flutter_boilerplate/core/models/models.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _dataSource;

  const ProductsRepositoryImpl({required ProductsRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  ResultFuture<DataWrapper<List<Product>>> getProducts({
    required ProductsParams params,
  }) {
    return execute<List<ProductModel>, DataWrapper<List<Product>>>(
      () => _dataSource.getProducts(params: params),
      mapper: (data) => DataWrapper(data: data.toEntity()),
    );
  }

  @override
  ResultFuture<DataWrapper<List<Product>>> searchProducts({
    required ProductsParams params,
  }) {
    return execute<List<ProductModel>, DataWrapper<List<Product>>>(
      () => _dataSource.searchProducts(params: params),
      mapper: (data) => DataWrapper(data: data.toEntity()),
    );
  }

  @override
  ResultFuture<Product> getProductById(int id) {
    return execute<ProductModel, Product>(
      () => _dataSource.getProductById(id),
      mapper: (data) => data.toEntity(),
    );
  }
}
