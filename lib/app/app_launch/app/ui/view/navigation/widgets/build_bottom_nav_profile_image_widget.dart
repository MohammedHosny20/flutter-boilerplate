part of '../../../imports/app_imports.dart';

class BuildBottomNavProfileImageWidget extends ConsumerWidget {
  const BuildBottomNavProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appControllerProvider);
    final controller = ref.read(appControllerProvider.notifier);
    return CircleAvatar(
      radius: PlayxPlatform.isCupertino ? 11 : 14,
      backgroundColor: controller.currentBottomNavIndex == state.bottomNavItems.length
          ? PlayxPlatform.isIOS
                ? context.colors.primary
                : context.colors.onSecondaryContainer
          : context.colors.onSurface,
      child: CircleAvatar(
        radius: PlayxPlatform.isCupertino ? 10 : 14,
        backgroundColor: context.colors.surface,
        child: ClipOval(
          child: Builder(
            builder: (context) {
              // final imageUrl = state.currentUser?.image?.url ?? '';
              const imageUrl = '';
              if (imageUrl.isEmpty) {
                return PlaceholderImageWidget(
                  path: Assets.images.profilePlaceholder,
                  padding: EdgeInsets.zero,
                );
              }
              return ImageViewer.cachedNetwork(
                imageUrl,
                errorBuilder:
                    (
                      context,
                      error,
                    ) => PlaceholderImageWidget(
                      path: Assets.images.profilePlaceholder,
                      padding: EdgeInsets.zero,
                    ),
                placeholderBuilder:
                    (
                      context,
                    ) => PlaceholderImageWidget(
                      path: Assets.images.profilePlaceholder,
                      padding: EdgeInsets.zero,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
