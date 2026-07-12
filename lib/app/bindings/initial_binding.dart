import 'package:get/get.dart';

import '../../core/network/dio_client.dart';
import '../../core/storage/local_cache_service.dart';
import '../../core/storage/secure_storage_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/leave_plan_requests_repository.dart';
import '../../data/repositories/leave_requests_repository.dart';
import '../../data/repositories/leave_types_repository.dart';
import '../../data/repositories/policies_repository.dart';
import '../../data/repositories/public_holidays_repository.dart';
import '../../data/repositories/recommends_repository.dart';
import '../../data/repositories/teams_repository.dart';
import '../../data/repositories/users_repository.dart';
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
    Get.put(TeamsRepository(dio: dioClient.dio));
    Get.put(LeaveRequestsRepository(dio: dioClient.dio));
    Get.put(LeavePlanRequestsRepository(dio: dioClient.dio));
    Get.put(LeaveTypesRepository(dio: dioClient.dio));
    Get.put(PublicHolidaysRepository(dio: dioClient.dio));
    Get.put(PoliciesRepository(dio: dioClient.dio));
    Get.put(UsersRepository(dio: dioClient.dio));
    Get.put(RecommendsRepository(dio: dioClient.dio));
    final authController = Get.put(
      AuthController(
        authRepository: Get.find(),
        teamsRepository: Get.find(),
        secureStorageService: Get.find(),
      ),
    );
    dioClient.onUnauthorized = authController.forceLogout;
  }
}
