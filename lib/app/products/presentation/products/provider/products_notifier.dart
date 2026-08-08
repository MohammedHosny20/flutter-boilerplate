import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/pagination/base_paged_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playx/playx.dart';

final productsNotifierProvider =
    NotifierProvider<ProductsNotifier, int?>(ProductsNotifier.new);

class ProductsNotifier extends BasePagedNotifier<Product> {
  @override
  Future<NetworkResult<DataWrapper<List<Product>>>> fetchPage({
    required int pageKey,
    CancelToken? cancelToken,
  }) {
    final query = searchQuery.value.trim();
    final params = ProductsParams(
      query: query,
      page: pageKey,
      pageSize: pageSize,
      cancelToken: cancelToken,
    );

    if (query.isEmpty) {
      return ref.read(getProductsUseCaseProvider)(params);
    }

    return ref.read(searchProductsUseCaseProvider)(params);
  }
}
