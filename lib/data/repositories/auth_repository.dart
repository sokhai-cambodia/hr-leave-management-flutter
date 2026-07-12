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
}
