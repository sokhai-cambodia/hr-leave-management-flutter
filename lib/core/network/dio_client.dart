import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants/env.dart';
import '../storage/secure_storage_service.dart';

/// Single Dio instance for the app: base URL from [Env], an auth-header
/// interceptor, and a 401/403 hook. [onUnauthorized] is left unset here —
/// Task 1.2 wires it up to force a logout + redirect to `/login`.
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
          if (statusCode == 401 || statusCode == 403) {
            onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );
  }

  final Dio dio;
  final SecureStorageService _secureStorageService;

  VoidCallback? onUnauthorized;
}
