import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';

  Future<void> saveToken(String token) =>
      _storage.write(key: _accessTokenKey, value: token);

  Future<String?> getToken() => _storage.read(key: _accessTokenKey);

  Future<void> deleteToken() => _storage.delete(key: _accessTokenKey);
}
