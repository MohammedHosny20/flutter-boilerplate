import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:playx/playx.dart';

class ProductsSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;

  const ProductsSearchField({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnly(start: 12, top: 8, end: 12, bottom: 4),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: AppTrans.searchProducts.tr(context: context),
              prefixIcon: IconInfo.icon(
                CupertinoIcons.search,
              ).buildIconWidget(),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      icon: IconInfo.icon(
                        CupertinoIcons.clear_circled,
                      ).buildIconWidget(),
                      onPressed: () {
                        controller.clear();
                        onSubmitted('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(borderRadius: 12.radius),
              contentPadding: context.paddingSymmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            onSubmitted: onSubmitted,
          );
        },
      ),
    );
  }
}
