import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:playx/playx.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductItem({
    required this.product,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomCard(
        margin: context.paddingSymmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: context.paddingAll(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: 10.radius,
                child: product.thumbnail.isNotEmpty
                    ? ImageViewer.cachedNetwork(
                        product.thumbnail,
                        width: 88.w,
                        height: 88.w,
                      )
                    : Container(
                        width: 88.w,
                        height: 88.w,
                        color: context.colors.primaryContainer,
                        child: Icon(
                          CupertinoIcons.cube_box,
                          color: context.colors.onPrimaryContainer,
                        ),
                      ),
              ),
              12.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      product.title,
                      textStyle: CustomTextStyles.title(context),
                      color: context.colors.onSurface,
                      maxLines: 2,
                    ),
                    if (product.brand != null) ...[
                      4.hBox,
                      CustomText(
                        product.brand!,
                        color: context.colors.subtitleTextColor,
                        fontSize: 13.sp,
                      ),
                    ],
                    6.hBox,
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: CustomText(
                                  '\$${product.discountedPrice.toStringAsFixed(2)}',
                                  textStyle: CustomTextStyles.title(context),
                                  color: context.colors.primary,
                                  maxLines: 1,
                                ),
                              ),
                              if (product.discountPercentage > 0) ...[
                                8.wBox,
                                Flexible(
                                  child: CustomText(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    color: context.colors.subtitleTextColor,
                                    fontSize: 12.sp,
                                    maxLines: 1,
                                    textStyle: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12.sp,
                                      color: context.colors.subtitleTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        8.wBox,
                        IconInfo.icon(
                          Icons.star_rounded,
                          size: 14.r,
                          color: AppColors.ratingStar,
                        ).buildIconWidget(),
                        4.wBox,
                        CustomText(
                          product.rating.toStringAsFixed(1),
                          fontSize: 12.sp,
                          color: context.colors.onSurface,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_right,
                color: context.colors.subtitleTextColor,
                size: 18.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
