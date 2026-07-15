part of '../imports/wishlist_imports.dart';

class WishlistView extends ConsumerWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wishlistControllerProvider);

    return CustomScaffold(
      title: AppTrans.wishlist,
      child: DataStateWidget(
        data: state.dataState,
        onSuccess: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return InkWell(
                onTap: () {
                  context.goNamed(Routes.wishlistDetails, extra: item);
                },
                child: CustomCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: ImageViewer.cachedNetwork(
                          item.imageUrl ??
                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0.w,
                          vertical: 12.h,
                        ),
                        child: CustomText(
                          item.name ?? "Lorem ipsum",
                          textStyle: CustomTextStyles.title(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
