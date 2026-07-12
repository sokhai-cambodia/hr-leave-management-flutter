import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_plan_request_model.dart';
import '../models/paginated_result.dart';

class LeavePlanRequestsRepository {
  LeavePlanRequestsRepository({required this._dio});

  final Dio _dio;

  /// Lists leave plan requests with pagination.
  Future<PaginatedResult<LeavePlanRequestModel>> fetchLeavePlanRequests({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-plan-requests/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => LeavePlanRequestModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Retrieves a specific leave plan request by ID.
  Future<LeavePlanRequestModel> fetchLeavePlanRequest(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-plan-requests/$id',
      );
      return LeavePlanRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Creates a draft leave plan request.
  Future<LeavePlanRequestModel> createLeavePlanRequest({
    String? description,
    required String leaveTypeId,
    required List<DateTime> dates,
  }) async {
    try {
      final details = dates
          .map((d) => {'leave_date': d.toIso8601String().split('T')[0]})
          .toList();

      final response = await _dio.post<Map<String, dynamic>>(
        '/leave-plan-requests/',
        data: {
          'description': description,
          'leave_type_id': leaveTypeId,
          'details': details,
        },
      );
      return LeavePlanRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Updates a draft leave plan request.
  Future<LeavePlanRequestModel> updateLeavePlanRequest(
    String id, {
    String? description,
    required String leaveTypeId,
    required List<DateTime> dates,
  }) async {
    try {
      final details = dates
          .map((d) => {'leave_date': d.toIso8601String().split('T')[0]})
          .toList();

      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-plan-requests/$id',
        data: {
          'description': description,
          'leave_type_id': leaveTypeId,
          'details': details,
        },
      );
      return LeavePlanRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Deletes a draft leave plan request.
  Future<void> deleteLeavePlanRequest(String id) async {
    try {
      await _dio.delete('/leave-plan-requests/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Submits a draft leave plan request.
  Future<LeavePlanRequestModel> submitLeavePlanRequest(String id) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-plan-requests/$id/submit',
      );
      return LeavePlanRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Approves a pending leave plan request.
  Future<LeavePlanRequestModel> approveLeavePlanRequest(String id) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-plan-requests/$id/approve',
      );
      return LeavePlanRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Rejects a pending leave plan request.
  Future<LeavePlanRequestModel> rejectLeavePlanRequest(String id) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-plan-requests/$id/reject',
      );
      return LeavePlanRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
