import 'package:flutter_boilerplate/app/products/data/data.dart';
import 'package:playx/playx.dart';

/// Contract for products remote IO.
abstract class ProductsRemoteDataSource {
  Future<NetworkResult<List<ProductModel>>> getProducts({
    required ProductsParams params,
  });

  Future<NetworkResult<List<ProductModel>>> searchProducts({
    required ProductsParams params,
  });

  Future<NetworkResult<ProductModel>> getProductById(int id);
}
