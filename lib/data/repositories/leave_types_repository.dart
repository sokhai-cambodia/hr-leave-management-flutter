import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_type_model.dart';
import '../models/paginated_result.dart';

class LeaveTypesRepository {
  LeaveTypesRepository({required this._dio});

  final Dio _dio;

  /// Fetches all leave types.
  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/leave-types/');
      final data = response.data!['data'] as List;
      return data
          .map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Paginated fetch for the admin CRUD list (Task 8.1) - [fetchLeaveTypes]
  /// stays as-is since other controllers depend on its plain-list shape.
  Future<PaginatedResult<LeaveTypeModel>> fetchLeaveTypesPage({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-types/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => LeaveTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<LeaveTypeModel> createLeaveType({
    required String code,
    required String name,
    required int entitlement,
    String? description,
    required bool isAllowPlan,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/leave-types/',
        data: {
          'code': code,
          'name': name,
          'entitlement': entitlement,
          'description': description,
          'is_allow_plan': isAllowPlan,
          'is_active': isActive,
        },
      );
      return LeaveTypeModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<LeaveTypeModel> updateLeaveType(
    String id, {
    required String code,
    required String name,
    required int entitlement,
    String? description,
    required bool isAllowPlan,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-types/$id',
        data: {
          'code': code,
          'name': name,
          'entitlement': entitlement,
          'description': description,
          'is_allow_plan': isAllowPlan,
          'is_active': isActive,
        },
      );
      return LeaveTypeModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteLeaveType(String id) async {
    try {
      await _dio.delete('/leave-types/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
