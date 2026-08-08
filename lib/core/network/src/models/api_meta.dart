part of '../../network.dart';

class ApiMeta {
  final Pagination pagination;

  const ApiMeta({required this.pagination});

  factory ApiMeta.fromJson(dynamic json) => ApiMeta(
    pagination: Pagination.fromJson(asMap(json, 'pagination')),
  );

  Map<String, dynamic> toJson() => {
    'pagination': pagination.toJson(),
  };
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;
  final bool? hasMore;

  const Pagination({
    this.page = 0,
    this.pageSize = 0,
    this.pageCount = 0,
    this.total = 0,
    this.hasMore = false,
  });

  factory Pagination.fromJson(dynamic json) => Pagination(
    page: asIntOr(json, 'page'),
    pageSize: asIntOr(json, 'pageSize'),
    pageCount: asIntOr(json, 'pageCount'),
    total: asIntOrNull(json, 'total') ?? asIntOr(json, 'records'),
    hasMore: asBoolOrNull(json, 'has_more') == true,
  );

  factory Pagination.fromEventsJson(dynamic json) {
    if (json == null) {
      return const Pagination();
    }

    final map = json as Map<String, dynamic>;

    final page = int.tryParse(asStringOr(map, 'page')) ?? asIntOr(map, 'page');
    final pageSize = asIntOr(map, 'page_size');

    final hasMore = asBoolOr(map, 'has_more');

    final pageCount = hasMore ? page + 1 : page;

    final total = asIntOrNull(map, 'total') ?? (hasMore ? (page * pageSize) + 1 : page * pageSize);

    return Pagination(
      page: page,
      pageSize: pageSize,
      pageCount: pageCount,
      total: total,
      hasMore: hasMore,
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'pageSize': pageSize,
    'pageCount': pageCount,
    'total': total,
    if (hasMore != null) 'has_more': hasMore,
  };
}

extension PaginationHasMore on Pagination {
  bool get hasMorePages {
    if (hasMore == true) {
      return true;
    }
    if (pageCount > 0) {
      return page < pageCount;
    }
    if (total > 0 && pageSize > 0) {
      final calculatedPageCount = (total / pageSize).ceil();
      return page < calculatedPageCount;
    }
    return false;
  }
}
