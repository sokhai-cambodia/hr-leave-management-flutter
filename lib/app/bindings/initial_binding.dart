import 'package:get/get.dart';

import '../../core/network/dio_client.dart';
import '../../core/storage/local_cache_service.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../features/auth/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    final secureStorageService = Get.put(SecureStorageService());
    Get.lazyPut(() => LocalCacheService());
    final dioClient = Get.put(
      DioClient(secureStorageService: secureStorageService),
    );
    Get.put(AuthRepository(dio: dioClient.dio));
    Get.put(
      AuthController(
        authRepository: Get.find(),
        secureStorageService: Get.find(),
      ),
    );
  }
}
