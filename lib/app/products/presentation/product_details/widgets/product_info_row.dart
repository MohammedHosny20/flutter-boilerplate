import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:playx/playx.dart';

class ProductInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProductInfoRow({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnly(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.r,
            child: CustomText(
              label,
              color: context.colors.subtitleTextColor,
            ),
          ),
          Expanded(
            child: CustomText(
              value,
              color: context.colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
