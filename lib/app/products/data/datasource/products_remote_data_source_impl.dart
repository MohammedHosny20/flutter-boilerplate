import 'package:flutter_boilerplate/app/products/data/data.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:playx/playx.dart';

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final PlayxNetworkClient _client;

  const ProductsRemoteDataSourceImpl({required PlayxNetworkClient client})
      : _client = client;

  @override
  Future<NetworkResult<List<ProductModel>>> getProducts({
    required ProductsParams params,
  }) {
    return _client.getList(
      Endpoints.products,
      query: {
        'limit': params.pageSize,
        'skip': (params.page - 1) * params.pageSize,
      },
      cancelToken: params.cancelToken,
      dataKey: ApiKeys.products.key,
      fromJson: ProductModel.fromJson,
    );
  }

  @override
  Future<NetworkResult<List<ProductModel>>> searchProducts({
    required ProductsParams params,
  }) {
    return _client.getList(
      Endpoints.productsSearch,
      query: {
        'q': params.query,
        'limit': params.pageSize,
        'skip': (params.page - 1) * params.pageSize,
      },
      cancelToken: params.cancelToken,
      dataKey: ApiKeys.products.key,
      fromJson: ProductModel.fromJson,
    );
  }

  @override
  Future<NetworkResult<ProductModel>> getProductById(int id) {
    return _client.get(
      Endpoints.productById(id),
      fromJson: ProductModel.fromJson,
    );
  }
}
