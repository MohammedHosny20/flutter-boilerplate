import 'package:flutter_boilerplate/app/products/data/data.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Feature composition root — wires data → domain for Products (list + details).
final productsRemoteDataSourceProvider =
    Provider<ProductsRemoteDataSource>((ref) {
  return ProductsRemoteDataSourceImpl(
    client: ref.watch(productsClientProvider),
  );
});

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepositoryImpl(
    dataSource: ref.watch(productsRemoteDataSourceProvider),
  );
});

final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(ref.watch(productsRepositoryProvider));
});

final searchProductsUseCaseProvider = Provider<SearchProductsUseCase>((ref) {
  return SearchProductsUseCase(ref.watch(productsRepositoryProvider));
});

final getProductDetailsUseCaseProvider =
    Provider<GetProductDetailsUseCase>((ref) {
  return GetProductDetailsUseCase(ref.watch(productsRepositoryProvider));
});
