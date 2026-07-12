import 'package:get/get.dart';

import '../../../core/errors/api_exception.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../views/login_view.dart';
import '../views/welcome_view.dart';

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
      Get.off(() => const WelcomeView());
    } on ApiException catch (e) {
      errorMessage.value = e.message;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _secureStorageService.deleteToken();
    currentUser.value = null;
    Get.off(() => const LoginView());
  }
}
