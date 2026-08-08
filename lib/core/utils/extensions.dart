import 'package:flutter/widgets.dart';
import 'package:playx/playx.dart';

extension DimensionsExt on num {
  SizedBox get hBox => SizedBox(height: toDouble(this).r);
  SizedBox get wBox => SizedBox(width: toDouble(this).r);
  BorderRadius get radius => BorderRadius.circular(toDouble(this).r);
  Radius get radiusCircular => Radius.circular(toDouble(this).r);
}

extension PaddingExt on BuildContext {
  EdgeInsetsDirectional paddingOnly({
    double end = 0,
    double top = 0,
    double start = 0,
    double bottom = 0,
  }) {
    return EdgeInsetsDirectional.only(
      end: end.r,
      top: top.r,
      start: start.r,
      bottom: bottom.r,
    );
  }

  EdgeInsetsDirectional paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsetsDirectional.symmetric(
      horizontal: horizontal.r,
      vertical: vertical.r,
    );
  }

  EdgeInsetsDirectional paddingAll(double value) {
    return EdgeInsetsDirectional.all(value.r);
  }

  EdgeInsets paddingZero() => EdgeInsets.zero;
}

extension ResponsiveGridExt on BuildContext {
  /// Resolves grid column count from width breakpoints.
  /// Defaults to `{1400: 3, 840: 2, 0: 1}`.
  int toCrossAxisCount([Map<double, int>? breakpoints]) {
    final map = breakpoints ??
        {
          1400: 3,
          840: 2,
          0: 1,
        };

    final width = MediaQuery.sizeOf(this).width;
    final sorted = map.keys.toList()..sort((a, b) => b.compareTo(a));

    for (final breakpoint in sorted) {
      if (width >= breakpoint) {
        return map[breakpoint]!;
      }
    }
    return 1;
  }
}
