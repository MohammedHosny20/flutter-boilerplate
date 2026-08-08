import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:playx/playx.dart';

class ProductInfoChip extends StatelessWidget {
  final IconInfo icon;
  final String label;

  const ProductInfoChip({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.colors.secondaryContainer,
        borderRadius: 20.radius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon.buildIconWidget(
            size: 14.r,
            color: context.colors.onSecondaryContainer,
          ),
          6.wBox,
          CustomText(
            label,
            fontSize: 12.sp,
            color: context.colors.onSecondaryContainer,
          ),
        ],
      ),
    );
  }
}
