import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailsProvider = NotifierProvider.autoDispose
    .family<ProductDetailsNotifier, DataState<Product>, int>(
      ProductDetailsNotifier.new,
    );

class ProductDetailsNotifier
    extends AutoDisposeFamilyNotifier<DataState<Product>, int> {
  int get productId => arg;

  @override
  DataState<Product> build(int productId) {
    Future.microtask(getProductDetails);
    return const DataState.initial();
  }

  Future<void> getProductDetails() async {
    state = const DataState.loading();

    final result = await ref.read(getProductDetailsUseCaseProvider)(productId);

    result.when(
      success: (data) {
        state = DataState.success(data);
      },
      error: (error) {
        state = DataState.error(DataError.error(error: error.message));
      },
    );
  }

  Future<void> retry() => getProductDetails();
}
