import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/paginated_result.dart';
import '../models/policy_model.dart';

class PoliciesRepository {
  PoliciesRepository({required this._dio});

  final Dio _dio;

  Future<PaginatedResult<PolicyModel>> fetchPolicies({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/policies/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => PolicyModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PolicyModel> createPolicy({
    required String code,
    required String name,
    String? operation,
    required String value,
    double? score,
    String? description,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/policies/',
        data: {
          'code': code,
          'name': name,
          'operation': operation,
          'value': value,
          'score': score,
          'description': description,
          'is_active': isActive,
        },
      );
      return PolicyModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<PolicyModel> updatePolicy(
    String id, {
    required String code,
    required String name,
    String? operation,
    required String value,
    double? score,
    String? description,
    required bool isActive,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/policies/$id',
        data: {
          'code': code,
          'name': name,
          'operation': operation,
          'value': value,
          'score': score,
          'description': description,
          'is_active': isActive,
        },
      );
      return PolicyModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deletePolicy(String id) async {
    try {
      await _dio.delete('/policies/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
