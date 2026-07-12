import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'token_storage.dart';

class SecureStorageService implements TokenStorage {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';

  @override
  Future<void> saveToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  @override
  Future<String?> getToken() => _storage.read(key: _accessTokenKey);

  @override
  Future<void> deleteToken() => _storage.delete(key: _accessTokenKey);
}
