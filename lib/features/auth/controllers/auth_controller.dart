import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/errors/api_exception.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController({
    required this._authRepository,
    required this._secureStorageService,
  });

  final AuthRepository _authRepository;
  final SecureStorageService _secureStorageService;

  final isLoading = false.obs;
  final errorMessage = RxnString();
  final currentUser = Rx<UserModel?>(null);

  final isRecoveryLoading = false.obs;
  final recoveryError = RxnString();
  final recoverySuccess = false.obs;

  final isResetLoading = false.obs;
  final resetError = RxnString();
  final resetSuccess = false.obs;

  bool _isHandlingUnauthorized = false;

  /// Runs once on app start: a stored token is validated against the
  /// backend before deciding whether to land on the welcome screen or
  /// the login screen, so authenticated UI never flashes unauthenticated
  /// (or vice versa).
  Future<void> bootstrap() async {
    final token = await _secureStorageService.getToken();
    if (token == null) {
      Get.offAllNamed(Routes.login);
      return;
    }

    try {
      currentUser.value = await _authRepository.testToken();
      Get.offAllNamed(Routes.welcome);
    } on ApiException {
      await _secureStorageService.deleteToken();
      Get.offAllNamed(Routes.login);
    }
  }

  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final token = await _authRepository.login(
        email: email,
        password: password,
      );
      await _secureStorageService.saveToken(token);
      currentUser.value = await _authRepository.fetchMe();
      Get.offAllNamed(Routes.welcome);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> recoverPassword({required String email}) async {
    isRecoveryLoading.value = true;
    recoveryError.value = null;
    recoverySuccess.value = false;
    try {
      await _authRepository.recoverPassword(email: email);
      recoverySuccess.value = true;
    } on ApiException catch (e) {
      recoveryError.value = e.message;
    } finally {
      isRecoveryLoading.value = false;
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    isResetLoading.value = true;
    resetError.value = null;
    resetSuccess.value = false;
    try {
      await _authRepository.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      resetSuccess.value = true;
    } on ApiException catch (e) {
      resetError.value = e.message;
    } finally {
      isResetLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _secureStorageService.deleteToken();
    currentUser.value = null;
    Get.offAllNamed(Routes.login);
  }

  /// Wired to DioClient.onUnauthorized — any 401/403 anywhere in the app
  /// forces a logout. Guarded so concurrent in-flight requests that all
  /// 401 at once only trigger one logout/redirect.
  Future<void> forceLogout() async {
    if (_isHandlingUnauthorized) return;
    _isHandlingUnauthorized = true;
    try {
      await logout();
    } finally {
      _isHandlingUnauthorized = false;
    }
  }
}
