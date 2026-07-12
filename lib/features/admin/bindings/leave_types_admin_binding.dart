import 'package:get/get.dart';

import '../controllers/leave_types_admin_controller.dart';

class LeaveTypesAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveTypesAdminController>(
      () => LeaveTypesAdminController(repository: Get.find()),
    );
  }
}
