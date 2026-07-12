import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/paginated_result.dart';
import '../models/user_model.dart';

class UsersRepository {
  UsersRepository({required this._dio});

  final Dio _dio;

  Future<PaginatedResult<UserModel>> fetchUsersPage({
    int skip = 0,
    int limit = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/users/',
        queryParameters: {'skip': skip, 'limit': limit},
      );
      final data = response.data!['data'] as List;
      final count = response.data!['count'] as int;
      final list = data
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedResult(data: list, count: count);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserModel> createUser({
    required String email,
    required String password,
    String? fullName,
    required bool isActive,
    required bool isSuperuser,
    String? teamId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/users/',
        data: {
          'email': email,
          'password': password,
          'full_name': fullName,
          'is_active': isActive,
          'is_superuser': isSuperuser,
          'team_id': teamId,
        },
      );
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// `password` is only included in the request body when non-null/non-empty
  /// - the backend does a partial update via Pydantic's `exclude_unset`, so
  /// a key that's merely *present* (even as `null`) is treated as "set the
  /// password to null" and crashes trying to hash it. Omitting the key
  /// entirely is what leaves the existing password untouched.
  Future<UserModel> updateUser(
    String id, {
    required String email,
    String? password,
    String? fullName,
    required bool isActive,
    required bool isSuperuser,
    String? teamId,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        '/users/$id',
        data: {
          'email': email,
          if (password != null && password.isNotEmpty) 'password': password,
          'full_name': fullName,
          'is_active': isActive,
          'is_superuser': isSuperuser,
          'team_id': teamId,
        },
      );
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _dio.delete('/users/$id');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
