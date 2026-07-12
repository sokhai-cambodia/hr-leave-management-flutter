import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/env.dart';
import '../storage/token_storage.dart';

/// Single Dio instance for the app: base URL from [Env], an auth-header
/// interceptor, and a session-invalidation hook. [onUnauthorized] fires on
/// 401/403 and on the backend's 400 "Inactive user" (its shape for a
/// deactivated account's still-valid token) — the caller (AuthController)
/// is responsible for guarding against concurrent double-fire.
class DioClient {
  DioClient({required this._secureStorageService})
    : dio = Dio(
        BaseOptions(
          baseUrl: Env.apiBaseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorageService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          final statusCode = error.response?.statusCode;
          final data = error.response?.data;
          final detail = data is Map ? data['detail'] : null;
          final isInvalidSession =
              statusCode == 401 ||
              statusCode == 403 ||
              (statusCode == 400 && detail == 'Inactive user');
          if (isInvalidSession) {
            onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  final TokenStorage _secureStorageService;

  VoidCallback? onUnauthorized;
}
