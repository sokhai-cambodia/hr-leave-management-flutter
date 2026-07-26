import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/audit_log_model.dart';
import '../models/paginated_result.dart';

class AuditLogsRepository {
  AuditLogsRepository({required this._dio});

  final Dio _dio;

  /// Lists audit log entries, newest first (superuser-only endpoint;
  /// non-superusers get a 403 from the backend). [entityType]/[action]
  /// narrow the trail to one resource kind or one kind of change.
  Future<PaginatedResult<AuditLogModel>> fetchAuditLogs({
    int skip = 0,
    int limit = 20,
    String? entityType,
    String? action,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'skip': skip, 'limit': limit};
      if (entityType != null) queryParameters['entity_type'] = entityType;
      if (action != null) queryParameters['action'] = action;

      final response = await _dio.get<Map<String, dynamic>>(
        '/audit-logs/',
        queryParameters: queryParameters,
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => AuditLogModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
