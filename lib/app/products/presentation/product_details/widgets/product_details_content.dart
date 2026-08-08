import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:playx/playx.dart';

class ProductDetailsContent extends StatelessWidget {
  final Product product;

  const ProductDetailsContent({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: context.paddingSymmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: 16.radius,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: ImageViewer.cachedNetwork(
                product.thumbnail,
                placeholderBuilder: (_) => const PlaceholderImageWidget(),
                errorBuilder: (_, _) => const PlaceholderImageWidget(),
              ),
            ),
          ),
          if (product.images.length > 1) ...[
            12.hBox,
            SizedBox(
              height: 72.0.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                separatorBuilder: (_, _) => 8.wBox,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: 10.radius,
                    child: ImageViewer.cachedNetwork(
                      product.images[index],
                      width: 72.w,
                      height: 72.h,
                      placeholderBuilder: (_) => const PlaceholderImageWidget(),
                      errorBuilder: (_, _) => const PlaceholderImageWidget(),
                    ),
                  );
                },
              ),
            ),
          ],
          16.hBox,
          CustomText(
            product.title,
            textStyle: CustomTextStyles.title(context),
            color: context.colors.onSurface,
            fontSize: 20.sp,
          ),
          if (product.brand != null) ...[
            4.hBox,
            CustomText(
              product.brand ?? 'N/A',
              color: context.colors.subtitleTextColor,
            ),
          ],
          12.hBox,
          Row(
            children: [
              CustomText(
                '\$${product.discountedPrice.toStringAsFixed(2)}',
                textStyle: CustomTextStyles.title(context),
                color: context.colors.primary,
                fontSize: 22.sp,
              ),
              if (product.discountPercentage > 0) ...[
                10.wBox,
                CustomText(
                  '\$${product.price.toStringAsFixed(2)}',
                  textStyle: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: context.colors.subtitleTextColor,
                    fontSize: 14.sp,
                  ),
                ),
                8.wBox,
                Container(
                  padding: context.paddingSymmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.colors.errorContainer,
                    borderRadius: 8.radius,
                  ),
                  child: CustomText(
                    '-${product.discountPercentage.toStringAsFixed(0)}%',
                    color: context.colors.onErrorContainer,
                    fontSize: 12.sp,
                  ),
                ),
              ],
              const Spacer(),
              IconInfo.icon(
                Icons.star_rounded,
                color: AppColors.ratingStar,
                size: 18.r,
              ).buildIconWidget(),
              4.wBox,
              CustomText(
                product.rating.toStringAsFixed(2),
                color: context.colors.onSurface,
              ),
            ],
          ),
          12.hBox,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              ProductInfoChip(
                icon: IconInfo.icon(CupertinoIcons.tag),
                label: product.category.capitalizeFirstChar,
              ),
              if (product.availabilityStatus != null)
                ProductInfoChip(
                  icon: IconInfo.icon(CupertinoIcons.cube_box),
                  label: product.availabilityStatus ?? 'N/A',
                ),
              ProductInfoChip(
                icon: IconInfo.icon(CupertinoIcons.number),
                label:
                    '${AppTrans.stock.tr(context: context)}: ${product.stock}',
              ),
            ],
          ),
          16.hBox,
          CustomText(
            AppTrans.description.tr(context: context),
            textStyle: CustomTextStyles.title(context),
            color: context.colors.onSurface,
          ),
          6.hBox,
          CustomText(
            product.description,
            color: context.colors.onSurface,
          ),
          if (product.warrantyInformation != null ||
              product.shippingInformation != null ||
              product.returnPolicy != null) ...[
            16.hBox,
            CustomText(
              AppTrans.productInfo.tr(context: context),
              textStyle: CustomTextStyles.title(context),
              color: context.colors.onSurface,
            ),
            8.hBox,
            if (product.warrantyInformation != null)
              ProductInfoRow(
                label: AppTrans.warranty.tr(context: context),
                value: product.warrantyInformation!,
              ),
            if (product.shippingInformation != null)
              ProductInfoRow(
                label: AppTrans.shipping.tr(context: context),
                value: product.shippingInformation!,
              ),
            if (product.returnPolicy != null)
              ProductInfoRow(
                label: AppTrans.returnPolicy.tr(context: context),
                value: product.returnPolicy!,
              ),
          ],
          if (product.reviews.isNotEmpty) ...[
            20.hBox,
            CustomText(
              AppTrans.reviews.tr(context: context),
              textStyle: CustomTextStyles.title(context),
              color: context.colors.onSurface,
            ),
            8.hBox,
            ...product.reviews.map(
              (review) => ProductReviewTile(review: review),
            ),
          ],
          24.hBox,
        ],
      ),
    );
  }
}
