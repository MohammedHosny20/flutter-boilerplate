part of '../imports/wishlist_imports.dart';

class WishlistDetailsView extends ConsumerWidget {
  final WishlistItem item;

  const WishlistDetailsView({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: item.name ?? AppTrans.wishlist,
      child: OptimizedScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: ImageViewer.cachedNetwork(
                    item.imageUrl ??
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomText(
                item.name ?? '',
                textStyle: CustomTextStyles.title(context),
              ),
              if (item.date != null) ...[
                SizedBox(height: 8.h),
                CustomText(
                  '${item.date!.day}/${item.date!.month}/${item.date!.year}',
                  textStyle: CustomTextStyles.subtitle(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
