import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_request_model.dart';
import '../models/paginated_result.dart';

class LeaveRequestsRepository {
  LeaveRequestsRepository({required this._dio});

  final Dio _dio;

  /// Lists leave requests with pagination.
  Future<PaginatedResult<LeaveRequestModel>> fetchLeaveRequests({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-requests/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => LeaveRequestModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Retrieves a specific leave request by ID.
  Future<LeaveRequestModel> fetchLeaveRequest(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-requests/$id',
      );
      return LeaveRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Creates a draft leave request.
  Future<LeaveRequestModel> createLeaveRequest({
    required DateTime startDate,
    required DateTime endDate,
    String? description,
    required String leaveTypeId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/leave-requests/',
        data: {
          'start_date': startDate.toIso8601String().split('T')[0],
          'end_date': endDate.toIso8601String().split('T')[0],
          'description': description,
          'leave_type_id': leaveTypeId,
        },
      );
      return LeaveRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Updates a draft leave request.
  Future<LeaveRequestModel> updateLeaveRequest(
    String id, {
    required DateTime startDate,
    required DateTime endDate,
    String? description,
    required String leaveTypeId,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-requests/$id',
        data: {
          'start_date': startDate.toIso8601String().split('T')[0],
          'end_date': endDate.toIso8601String().split('T')[0],
          'description': description,
          'leave_type_id': leaveTypeId,
        },
      );
      return LeaveRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Deletes a draft leave request.
  Future<void> deleteLeaveRequest(String id) async {
    try {
      await _dio.delete('/leave-requests/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Submits a draft leave request.
  Future<LeaveRequestModel> submitLeaveRequest(String id) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-requests/$id/submit',
      );
      return LeaveRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Approves a pending leave request.
  Future<LeaveRequestModel> approveLeaveRequest(String id) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-requests/$id/approve',
      );
      return LeaveRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Rejects a pending leave request.
  Future<LeaveRequestModel> rejectLeaveRequest(String id) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-requests/$id/reject',
      );
      return LeaveRequestModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
