/// Storage contract for the JWT access token. Lets DioClient and its unit
/// tests depend on an interface instead of the platform-channel-backed
/// SecureStorageService.
abstract class TokenStorage {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();
}
