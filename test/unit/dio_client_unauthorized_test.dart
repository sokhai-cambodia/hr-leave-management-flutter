import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hr_leave_management/core/network/dio_client.dart';
import 'package:hr_leave_management/core/storage/token_storage.dart';

void main() {
  group('DioClient session-invalidation handling', () {
    test('a 401 response triggers onUnauthorized', () async {
      final dioClient = DioClient(secureStorageService: _FakeTokenStorage());
      dioClient.dio.httpClientAdapter = _FixedStatusAdapter(401);

      var callCount = 0;
      dioClient.onUnauthorized = () => callCount++;

      await expectLater(
        dioClient.dio.get<void>('/anything'),
        throwsA(isA<DioException>()),
      );

      expect(callCount, 1);
    });

    test('a 403 response also triggers onUnauthorized', () async {
      final dioClient = DioClient(secureStorageService: _FakeTokenStorage());
      dioClient.dio.httpClientAdapter = _FixedStatusAdapter(403);

      var callCount = 0;
      dioClient.onUnauthorized = () => callCount++;

      await expectLater(
        dioClient.dio.get<void>('/anything'),
        throwsA(isA<DioException>()),
      );

      expect(callCount, 1);
    });

    test(
      'a 400 "Inactive user" response (deactivated account) triggers onUnauthorized',
      () async {
        final dioClient = DioClient(secureStorageService: _FakeTokenStorage());
        dioClient.dio.httpClientAdapter = _FixedStatusAdapter(
          400,
          body: '{"detail": "Inactive user"}',
        );

        var callCount = 0;
        dioClient.onUnauthorized = () => callCount++;

        await expectLater(
          dioClient.dio.get<void>('/anything'),
          throwsA(isA<DioException>()),
        );

        expect(callCount, 1);
      },
    );

    test(
      'a 400 with an unrelated detail (e.g. bad login) does not trigger onUnauthorized',
      () async {
        final dioClient = DioClient(secureStorageService: _FakeTokenStorage());
        dioClient.dio.httpClientAdapter = _FixedStatusAdapter(
          400,
          body: '{"detail": "Incorrect email or password"}',
        );

        var callCount = 0;
        dioClient.onUnauthorized = () => callCount++;

        await expectLater(
          dioClient.dio.get<void>('/anything'),
          throwsA(isA<DioException>()),
        );

        expect(callCount, 0);
      },
    );

    test('a 200 response does not trigger onUnauthorized', () async {
      final dioClient = DioClient(secureStorageService: _FakeTokenStorage());
      dioClient.dio.httpClientAdapter = _FixedStatusAdapter(200);

      var callCount = 0;
      dioClient.onUnauthorized = () => callCount++;

      await dioClient.dio.get<void>('/anything');

      expect(callCount, 0);
    });
  });
}

class _FakeTokenStorage implements TokenStorage {
  String? _token;

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> saveToken(String token) async => _token = token;

  @override
  Future<void> deleteToken() async => _token = null;
}

class _FixedStatusAdapter implements HttpClientAdapter {
  _FixedStatusAdapter(this.statusCode, {this.body = '{}'});

  final int statusCode;
  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
