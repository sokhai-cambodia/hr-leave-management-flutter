import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/errors/api_exception.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/teams_repository.dart';

class AuthController extends GetxController {
  AuthController({
    required this._authRepository,
    required this._teamsRepository,
    required this._secureStorageService,
  });

  final AuthRepository _authRepository;
  final TeamsRepository _teamsRepository;
  final SecureStorageService _secureStorageService;

  final isLoading = false.obs;
  final errorMessage = RxnString();
  final currentUser = Rx<UserModel?>(null);

  /// "Am I a team owner" — computed once per session (login/bootstrap), not
  /// re-fetched per screen. No direct `is_team_owner` flag exists on `User`;
  /// this is the only viable heuristic (see Task 2.2).
  final isApprover = false.obs;

  final isRecoveryLoading = false.obs;
  final recoveryError = RxnString();
  final recoverySuccess = false.obs;

  final isResetLoading = false.obs;
  final resetError = RxnString();
  final resetSuccess = false.obs;

  bool _isHandlingUnauthorized = false;

  /// Runs once on app start: a stored token is validated against the
  /// backend before deciding whether to land on the dashboard or
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
      await _refreshApproverStatus();
      Get.offAllNamed(Routes.dashboard);
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
      await _refreshApproverStatus();
      Get.offAllNamed(Routes.dashboard);
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  /// Failures here don't block login/bootstrap — losing the Approvals nav
  /// entry is a minor degradation, not a reason to force a logout.
  Future<void> _refreshApproverStatus() async {
    final userId = currentUser.value?.id;
    if (userId == null) return;
    try {
      final teams = await _teamsRepository.fetchTeams();
      isApprover.value = teams.any((team) => team.teamOwnerId == userId);
    } on ApiException {
      isApprover.value = false;
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
    isApprover.value = false;
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
