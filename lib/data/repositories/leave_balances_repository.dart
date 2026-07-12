import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/leave_balance_model.dart';

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
}
