import 'package:get/get.dart';

import '../controllers/leave_plan_requests_controller.dart';

class LeavePlanRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeavePlanRequestsController>(
      () => LeavePlanRequestsController(
        leavePlanRequestsRepository: Get.find(),
      ),
    );
  }
}
