part of '../imports/wishlist_imports.dart';

class WishlistState {
  final DataState<List<WishlistItem>> dataState;

  WishlistState({this.dataState = const DataState.initial()});

  WishlistState copyWith({DataState<List<WishlistItem>>? dataState}) {
    return WishlistState(dataState: dataState ?? this.dataState);
  }
}

class WishlistController extends Notifier<WishlistState> {
  StreamSubscription<List<WishlistItem>>? _watchWishlistItemsSub;

  @override
  WishlistState build() {
    ref.onDispose(() {
      _watchWishlistItemsSub?.cancel();
    });
    Future.microtask(() => watchWishlistItems());
    return WishlistState();
  }

  Future<void> watchWishlistItems() async {
    state = state.copyWith(dataState: const DataState.loading());

    final repository = await ref.read(wishlistRepositoryProvider.future);

    await Future.delayed(const Duration(seconds: 2));
    _watchWishlistItemsSub?.cancel();
    _watchWishlistItemsSub = repository.watchAllWishlistItems().listen((data) {
      if (data.isEmpty) {
        state = state.copyWith(
          dataState: const DataState<List<WishlistItem>>.error(
            DataError.empty(),
          ),
        );
        return;
      }
      state = state.copyWith(dataState: DataState.success(data));
    });
  }
}

final wishlistControllerProvider = NotifierProvider<WishlistController, WishlistState>(
  WishlistController.new,
);
