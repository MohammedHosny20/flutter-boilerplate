import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playx/playx.dart';

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(productsNotifierProvider.notifier);

    return CustomScaffold(
      title: AppTrans.products,
      leading: AppBarLeadingType.drawerOrRail,
      child: RefreshIndicator(
        onRefresh: notifier.refreshData,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProductsSearchField(
                controller: notifier.searchController,
                onSubmitted: notifier.updateSearch,
              ),
            ),
            ResponsivePagedSliverView<int, Product>(
              pagingController: notifier.pagingController,
              emptyDataMessage: AppTrans.noProductsFound.tr(context: context),
              itemBuilder: (context, product, index) {
                return ProductItem(
                  product: product,
                  onTap: () {
                    AppNavigation.navigateToProductDetails(id: product.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
