import 'package:get/get.dart';

import '../controllers/leave_balances_admin_controller.dart';

class LeaveBalancesAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveBalancesAdminController>(
      () => LeaveBalancesAdminController(
        repository: Get.find(),
        usersRepository: Get.find(),
        leaveTypesRepository: Get.find(),
      ),
    );
  }
}
