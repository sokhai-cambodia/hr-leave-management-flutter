import 'package:get/get.dart';

import '../controllers/leave_requests_controller.dart';

class LeaveRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveRequestsController>(
      () => LeaveRequestsController(
        leaveRequestsRepository: Get.find(),
      ),
    );
  }
}
