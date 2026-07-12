import 'package:dio/dio.dart';

/// Maps FastAPI's two error-response shapes into one readable message:
/// `{"detail": "some string"}` and 422's `{"detail": [{loc, msg, type}, ...]}`.
class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;

  factory ApiException.fromDioException(DioException e) {
    final response = e.response;
    if (response == null) {
      return ApiException(_networkErrorMessage(e));
    }
    final message =
        _extractMessage(response.data) ??
        'Something went wrong (${response.statusCode}).';
    return ApiException(message, statusCode: response.statusCode);
  }

  static String? _extractMessage(dynamic data) {
    if (data is! Map || !data.containsKey('detail')) return null;

    final detail = data['detail'];
    if (detail is String) return detail;

    if (detail is List) {
      final messages = detail
          .whereType<Map>()
          .map((entry) => entry['msg']?.toString())
          .whereType<String>()
          .toList();
      if (messages.isNotEmpty) return messages.join('\n');
    }

    return null;
  }

  static String _networkErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'Could not connect to the server. Check your connection and try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
