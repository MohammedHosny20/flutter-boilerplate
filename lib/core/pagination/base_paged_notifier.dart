import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:playx/playx.dart';

/// Base Riverpod notifier for infinite lists backed by [PagingController].
///
/// Children implement [fetchPage] and typically just forward to a use case /
/// repository that already returns [NetworkResult]<[DataWrapper]>.
abstract class BasePagedNotifier<T> extends Notifier<int?> {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> searchQuery = ValueNotifier('');

  late final PagingController<int, T> pagingController = PagingController(
    firstPageKey: 1,
  );

  final ValueNotifier<int?> totalItemsCount = ValueNotifier(null);
  final ValueNotifier<int?> totalPagesCount = ValueNotifier(null);
  final isLoadingListenable = ValueNotifier(false);

  CancelToken? _cancelToken;
  int _seq = 0;
  int? _pageSize;

  Future<NetworkResult<DataWrapper<List<T>>>> fetchPage({
    required int pageKey,
    CancelToken? cancelToken,
  });

  @override
  int? build() {
    pagingController.addPageRequestListener(_handlePageRequest);
    ref.onDispose(dispose);
    return null;
  }

  Future<void> _handlePageRequest(int pageKey) async {
    final id = ++_seq;
    isLoadingListenable.value = true;
    try {
      _cancelToken?.cancel('cancelled previous');
      _cancelToken = CancelToken();

      final res = await fetchPage(pageKey: pageKey, cancelToken: _cancelToken);

      if (id != _seq) return;

      res.when(
        success: (data) {
          final items = data.data;
          final isLastPage = data.isLastPage ||
              (data.pagination == null && items.length < pageSize);

          totalItemsCount.value = data.pagination?.total;
          totalPagesCount.value = data.pagination?.pageCount;
          state = data.pagination?.total;

          if (items.isEmpty && pageKey == 1 && isLastPage) {
            pagingController.error = const DataError.empty(
              error: AppTrans.emptyResponse,
            );
            return;
          }
          final pageItems = _buildPageItems(items);
          if (isLastPage) {
            pagingController.appendLastPage(pageItems);
          } else {
            pagingController.appendPage(pageItems, pageKey + 1);
          }
        },
        error: (error) {
          if (error is RequestCanceledException) return;
          pagingController.error = error.message;
        },
      );
    } catch (error) {
      if (id != _seq) return;
      if (error is RequestCanceledException) return;
      pagingController.error = error.toString();
    } finally {
      if (id == _seq) {
        isLoadingListenable.value = false;
      }
    }
  }

  int get pageSize => _pageSize ?? 20;

  List<T> _buildPageItems(List<T> items) {
    final existing = pagingController.itemList ?? const [];
    final unique = <T>[];
    for (final item in items) {
      if (existing.contains(item) || unique.contains(item)) continue;
      unique.add(item);
    }
    return unique;
  }

  List<T> get items => pagingController.itemList ?? const [];

  bool get hasMore => pagingController.nextPageKey != null;

  bool get isLoadingMore => isLoadingListenable.value;

  Future<void> ensureInitialized() async {
    if (pagingController.itemList != null) return;
    if (isLoadingListenable.value) return;
    await pagingController
        .notifyPageRequestListeners(pagingController.firstPageKey);
  }

  Future<void> fetchNextPage() async {
    final nextKey = pagingController.nextPageKey;
    if (nextKey == null || isLoadingListenable.value) return;
    await pagingController.notifyPageRequestListeners(nextKey);
  }

  Future<void> setPageSize(int size) async {
    if (size <= 0 || pageSize == size) return;
    _pageSize = size;
    await refreshData();
  }

  Future<void> refreshData() async {
    pagingController.refresh();
    await pagingController
        .notifyPageRequestListeners(pagingController.firstPageKey);
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    refreshData();
  }

  void saveFilters() => refreshData();

  void dispose() {
    isLoadingListenable.dispose();
    searchController.dispose();
    searchQuery.dispose();
    totalItemsCount.dispose();
    totalPagesCount.dispose();
    pagingController.dispose();
    _cancelToken?.cancel('notifier disposed');
  }
}
