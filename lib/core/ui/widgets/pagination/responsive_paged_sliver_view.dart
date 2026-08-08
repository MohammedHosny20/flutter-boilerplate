part of '../../ui.dart';

/// Responsive sliver that shows [PagingController] items as a list or grid
/// based on screen width.
class ResponsivePagedSliverView<P, T> extends StatelessWidget {
  const ResponsivePagedSliverView({
    required this.pagingController,
    required this.itemBuilder,
    this.responsiveCrossAxisCounts,
    this.padding,
    this.gridMainAxisSpacing = 8,
    this.gridCrossAxisSpacing = 8,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.emptyDataMessage,
    this.heightFactor = 0.5,
    super.key,
  });

  final PagingController<P, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Breakpoint → column count. Keys should prefer larger widths first.
  /// Defaults to `{1400: 3, 840: 2, 0: 1}`.
  final Map<double, int>? responsiveCrossAxisCounts;

  final double heightFactor;
  final EdgeInsetsGeometry? padding;
  final double gridMainAxisSpacing;
  final double gridCrossAxisSpacing;

  final WidgetBuilder? firstPageErrorIndicatorBuilder;
  final WidgetBuilder? firstPageProgressIndicatorBuilder;
  final WidgetBuilder? newPageProgressIndicatorBuilder;
  final WidgetBuilder? newPageErrorIndicatorBuilder;
  final WidgetBuilder? noItemsFoundIndicatorBuilder;
  final String? emptyDataMessage;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = context.toCrossAxisCount(responsiveCrossAxisCounts);
    final effectivePadding = padding ??
        context.paddingOnly(
          start: 8,
          end: 8,
          top: 8,
          bottom: MediaQuery.paddingOf(context).bottom + 72,
        );

    final delegate = PagedChildBuilderDelegate<T>(
      itemBuilder: itemBuilder,
      animateTransitions: true,
      firstPageErrorIndicatorBuilder: firstPageErrorIndicatorBuilder ??
          (_) => SizedBox(
                height: context.height * 0.4,
                child: EmptyDataWidget(
                  error: emptyDataMessage ??
                      AppTrans.defaultError.tr(context: context),
                  onRetryClicked: pagingController.refresh,
                ),
              ),
      noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder ??
          (_) => SizedBox(
                height: context.height * 0.4,
                child: EmptyDataWidget(
                  error: emptyDataMessage ??
                      AppTrans.emptyResponse.tr(context: context),
                  onRetryClicked: pagingController.refresh,
                ),
              ),
      firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder ??
          (_) => SizedBox(
                height: context.height * 0.4,
                child: const CustomLoading(),
              ),
      newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder ??
          (_) => Padding(
                padding: context.paddingAll(16.0),
                child: const Center(child: CustomLoading()),
              ),
      newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder,
    );

    return SliverPadding(
      padding: effectivePadding,
      sliver: crossAxisCount <= 1
          ? PagedSliverList<P, T>(
              pagingController: pagingController,
              builderDelegate: delegate,
            )
          : PagedSliverAlignedGrid<P, T>.count(
              pagingController: pagingController,
              builderDelegate: delegate,
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: gridMainAxisSpacing,
              crossAxisSpacing: gridCrossAxisSpacing,
            ),
    );
  }
}
