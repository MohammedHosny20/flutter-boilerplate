import 'package:flutter_boilerplate/app/products/domain/domain.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/src/result_types.dart';

/// Contract for product catalog operations.
///
/// Lives in the domain layer so presentation and use cases depend only on
/// abstractions — never on Dio / PlayxNetworkClient / API DTOs.
///
/// List APIs use 1-based [page] / [pageSize] and return [DataWrapper] so
/// presentation can forward the result straight into [BasePagedNotifier].
abstract class ProductsRepository {
  ResultFuture<DataWrapper<List<Product>>> getProducts({
    required ProductsParams params,
  });

  ResultFuture<DataWrapper<List<Product>>> searchProducts({
    required ProductsParams params,
  });

  ResultFuture<Product> getProductById(int id);
}
