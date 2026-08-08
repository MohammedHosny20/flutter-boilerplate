part of '../../models.dart';

extension ApiResponseToDataWrapper<T> on ApiResponse<T> {
  DataWrapper<T> toDataWrapper() {
    return DataWrapper<T>(
      data: data,
      pagination: meta?.toPageInfo(),
      hasMore: meta?.pagination.hasMore,
      message: message,
    );
  }

  DataWrapper<S> toDataWrapperAndMapData<S>({
    required S Function(T data) mapper,
  }) {
    return DataWrapper<S>(
      data: mapper(data),
      pagination: meta?.toPageInfo(),
      hasMore: meta?.pagination.hasMore,
      message: message,
    );
  }
}

extension ApiMetaToPageInfo on ApiMeta {
  PageInfo toPageInfo() {
    return PageInfo(
      page: pagination.page,
      pageCount: pagination.pageCount,
      pageSize: pagination.pageSize,
      total: pagination.total,
      hasMore: pagination.hasMore,
    );
  }
}
