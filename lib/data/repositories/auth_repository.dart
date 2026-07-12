import 'package:dio/dio.dart';

import '../../core/errors/api_exception.dart';
import '../models/user_model.dart';

class AuthRepository {
  AuthRepository({required this._dio});

  final Dio _dio;

  /// OAuth2 password flow — FastAPI expects a form-encoded body.
  Future<String> login({required String email, required String password}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/login/access-token',
        data: {'username': email, 'password': password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return response.data!['access_token'] as String;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<UserModel> fetchMe() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/users/me');
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Validates the token currently attached by DioClient's auth-header
  /// interceptor; used for session bootstrap on app start.
  Future<UserModel> testToken() async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/login/test-token',
      );
      return UserModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Email is a path segment, not a body field — matches the backend route.
  Future<void> recoverPassword({required String email}) async {
    try {
      await _dio.post<Map<String, dynamic>>('/password-recovery/$email');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await _dio.post<Map<String, dynamic>>(
        '/reset-password/',
        data: {'token': token, 'new_password': newPassword},
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
