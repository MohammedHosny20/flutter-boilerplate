part of '../../network.dart';

class ApiResponse<T> {
  final T data;
  final ApiMeta? meta;
  final String? message;

  const ApiResponse({
    required this.data,
    this.meta,
    this.message,
  });

  factory ApiResponse.fromJson({
    dynamic json,
    required T Function(dynamic) dataFromJson,
    String dataKey = 'data',
  }) {
    final map = json as Map<String, dynamic>;
    final data = dataFromJson(map[dataKey]);

    return ApiResponse(
      data: data,
      meta: map.toMetaOrNull(),
      message: asStringOrNull(map, 'message'),
    );
  }

  static ApiResponse<List<T>> createApiResponseFromJsonDataList<T>({
    dynamic json,
    required T Function(dynamic) dataFromJson,
    String dataKey = 'data',
  }) {
    final map = json as Map<String, dynamic>;
    final data = asList(map, dataKey).map((e) => dataFromJson(e)).toList();

    return ApiResponse(
      data: data,
      meta: map.toMetaOrNull(),
      message: asStringOrNull(map, 'message'),
    );
  }

  /// List envelope: `{ "data": { "data": [...], "meta": { "pagination": ... } } }`.
  static ApiResponse<List<T>> createClientListResponse<T>({
    required dynamic json,
    required T Function(dynamic) dataFromJson,
  }) {
    final root = json as Map<String, dynamic>;
    final envelope = asMap(root, 'data');
    return createApiResponseFromJsonDataList(
      json: envelope,
      dataFromJson: dataFromJson,
    );
  }

  static T parseClientData<T>(
    dynamic json,
    T Function(dynamic itemJson) dataFromJson,
  ) {
    final map = json as Map<String, dynamic>;
    final data = map['data'];
    if (data is Map<String, dynamic>) {
      return dataFromJson(data);
    }
    return dataFromJson(map);
  }

  Map<String, dynamic> toJson({
    required Map<String, dynamic> Function(T data) toDataJson,
  }) => {
        'data': toDataJson(data),
        if (meta != null) 'meta': meta?.toJson(),
      };

  Future<Map<String, dynamic>> toJsonAsync({
    required Future<Map<String, dynamic>> Function(T data) toDataJson,
  }) async => {
        'data': await toDataJson(data),
        if (meta != null) 'meta': meta?.toJson(),
      };

  Map<String, dynamic> toJsonList({
    required List<Map<String, dynamic>> Function(T data) toDataJson,
  }) => {
        'data': toDataJson(data),
        if (meta != null) 'meta': meta?.toJson(),
      };
}

extension ApiResponseExtension<T> on ApiResponse<T> {
  ApiResponse<T> copyWith({
    T? data,
    ApiMeta? meta,
    String? message,
  }) =>
      ApiResponse<T>(
        data: data ?? this.data,
        meta: meta ?? this.meta,
        message: message ?? this.message,
      );
  bool get hasData => data != null;
  bool get hasMeta => meta != null;
  bool get hasMessage => message != null;
}

extension ApiResponseJsonMap on Map<String, dynamic> {
  ApiMeta? toMetaOrNull() {
    final metaJson = this['meta'];
    if (metaJson is Map<String, dynamic>) {
      final paginationJson = metaJson['pagination'];
      if (paginationJson != null) {
        return ApiMeta.fromJson(metaJson);
      }
    }
    final paginationJson = this['pagination'];
    if (paginationJson != null) {
      return ApiMeta(
        pagination: Pagination.fromJson(
          paginationJson as Map<String, dynamic>?,
        ),
      );
    }
    return null;
  }
}
