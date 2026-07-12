import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/core/errors/api_exception.dart';

void main() {
  group('ApiException.fromDioException', () {
    test('maps a plain string detail', () {
      final exception = ApiException.fromDioException(
        _dioExceptionWith(
          statusCode: 400,
          data: {'detail': 'Incorrect email or password'},
        ),
      );

      expect(exception.message, 'Incorrect email or password');
      expect(exception.statusCode, 400);
    });

    test('flattens a 422 validation-error list into one readable string', () {
      final exception = ApiException.fromDioException(
        _dioExceptionWith(
          statusCode: 422,
          data: {
            'detail': [
              {
                'loc': ['body', 'email'],
                'msg': 'field required',
                'type': 'value_error.missing',
              },
              {
                'loc': ['body', 'password'],
                'msg': 'ensure this value has at least 8 characters',
                'type': 'value_error.any_str.min_length',
              },
            ],
          },
        ),
      );

      expect(
        exception.message,
        'field required\nensure this value has at least 8 characters',
      );
      expect(exception.statusCode, 422);
    });

    test('falls back to a generic message with no response body', () {
      final requestOptions = RequestOptions(path: '/utils/health-check/');
      final exception = ApiException.fromDioException(
        DioException(
          requestOptions: requestOptions,
          type: DioExceptionType.connectionError,
        ),
      );

      expect(exception.message, contains('Could not connect'));
      expect(exception.statusCode, isNull);
    });
  });
}

DioException _dioExceptionWith({
  required int statusCode,
  required Map<String, dynamic> data,
}) {
  final requestOptions = RequestOptions(path: '/test');
  final response = Response(
    requestOptions: requestOptions,
    statusCode: statusCode,
    data: data,
  );
  return DioException(
    requestOptions: requestOptions,
    response: response,
    type: DioExceptionType.badResponse,
  );
}
