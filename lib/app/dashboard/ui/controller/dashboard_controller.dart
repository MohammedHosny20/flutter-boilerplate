part of '../imports/dashboard_imports.dart';

/// State for the dashboard notifier.
class DashboardState {
  final DataState<List<DashboardItem>> dataState;

  DashboardState({this.dataState = const DataState.initial()});

  DashboardState copyWith({DataState<List<DashboardItem>>? dataState}) {
    return DashboardState(dataState: dataState ?? this.dataState);
  }
}

/// Riverpod notifier that replaces [DashboardController].
class DashboardController extends Notifier<DashboardState> {
  final List<DashboardItem> _items = List.generate(
    20,
    (index) => DashboardItem(
      id: index + 1,
      imageUrl: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      name: 'Lorem ipsum #${index + 1}',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, consectetur adipiscing elit sed diam nonum y eirmod tempor invidunt ut labore et dol',
    ),
  );

  @override
  DashboardState build() {
    Future.microtask(() => getDashboardItems());
    return DashboardState();
  }

  Future<void> getDashboardItems() async {
    state = state.copyWith(dataState: const DataState.loading());
    final wishlistRepository = await ref.read(wishlistRepositoryProvider.future);
    final wishlistItems = await wishlistRepository.getAllWishlistItems();

    for (final item in _items) {
      final isFavorite = wishlistItems.any((element) => element.id == item.id);
      item.isFavorite = isFavorite;
    }

    state = state.copyWith(dataState: DataState.success(_items));
  }

  Future<void> onFavoriteChanged(bool isFavorite, DashboardItem item) async {
    final wishlistRepository = await ref.read(wishlistRepositoryProvider.future);
    if (isFavorite) {
      wishlistRepository.insertWishlistItem(
        WishlistItem(
          id: item.id,
          imageUrl: item.imageUrl,
          name: item.name,
        ),
      );
    } else {
      wishlistRepository.deleteWishlistItem(
        WishlistItem(
          id: item.id,
          imageUrl: item.imageUrl,
          name: item.name,
        ),
      );
    }
  }
}

/// Provider for [DashboardController].
final dashboardControllerProvider = NotifierProvider<DashboardController, DashboardState>(
  DashboardController.new,
);
