import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_balance_model.dart';
import '../models/paginated_result.dart';

class LeaveBalancesRepository {
  LeaveBalancesRepository({required this._dio});

  final Dio _dio;

  /// `GET /leave-balances/me` — server scopes to the current user and the
  /// current server year, auto-generating rows on first fetch. No client
  /// year param exists to pass.
  Future<List<LeaveBalanceModel>> fetchMyBalances() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-balances/me',
      );
      final data = response.data!['data'] as List;
      return data
          .map((e) => LeaveBalanceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// `GET /leave-balances/` — admin list across all users, superuser-only
  /// server-side.
  Future<PaginatedResult<LeaveBalanceModel>> fetchBalancesPage({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/leave-balances/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => LeaveBalanceModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<LeaveBalanceModel> createBalance({
    required String year,
    required double balance,
    required String leaveTypeId,
    required String ownerId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/leave-balances/',
        data: {
          'year': year,
          'balance': balance,
          'leave_type_id': leaveTypeId,
          'owner_id': ownerId,
        },
      );
      return LeaveBalanceModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<LeaveBalanceModel> updateBalance(
    String id, {
    required String year,
    required double balance,
    required String leaveTypeId,
    required String ownerId,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/leave-balances/$id',
        data: {
          'year': year,
          'balance': balance,
          'leave_type_id': leaveTypeId,
          'owner_id': ownerId,
        },
      );
      return LeaveBalanceModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteBalance(String id) async {
    try {
      await _dio.delete('/leave-balances/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
