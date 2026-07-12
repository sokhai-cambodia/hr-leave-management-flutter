import 'package:get/get.dart';

import '../../../core/network/dio_client.dart';
import '../../../data/repositories/leave_balances_repository.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LeaveBalancesRepository(dio: Get.find<DioClient>().dio),
    );
    Get.lazyPut(
      () => DashboardController(leaveBalancesRepository: Get.find()),
    );
  }
}
