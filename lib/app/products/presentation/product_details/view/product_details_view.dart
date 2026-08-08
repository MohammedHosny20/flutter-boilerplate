import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsView extends ConsumerWidget {
  final int productId;

  const ProductDetailsView({required this.productId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailsProvider(productId));
    final notifier = ref.read(productDetailsProvider(productId).notifier);

    return CustomScaffold(
      title: AppTrans.productDetails,
      leading: AppBarLeadingType.back,
      child: DataStateWidget(
        data: state,
        onSuccess: (product) => ProductDetailsContent(product: product),
        onRetryClicked: notifier.retry,
        onNoInternetRetryClicked: notifier.retry,
      ),
    );
  }
}
