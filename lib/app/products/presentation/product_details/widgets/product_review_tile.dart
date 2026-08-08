import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/products/presentation/presentation.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:playx/playx.dart';

class ProductReviewTile extends StatelessWidget {
  final ProductReview review;

  const ProductReviewTile({required this.review, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      margin: context.paddingOnly(bottom: 8),
      child: Padding(
        padding: context.paddingAll(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    review.reviewerName,
                    textStyle: CustomTextStyles.title(context),
                    color: context.colors.onSurface,
                  ),
                ),
                IconInfo.icon(
                  Icons.star_rounded,
                  size: 14.r,
                  color: AppColors.ratingStar,
                ).buildIconWidget(),
                4.wBox,
                CustomText(
                  '${review.rating}',
                  color: context.colors.onSurface,
                ),
              ],
            ),
            6.hBox,
            CustomText(
              review.comment,
              color: context.colors.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
