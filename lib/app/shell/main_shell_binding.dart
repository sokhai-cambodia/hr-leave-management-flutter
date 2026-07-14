import 'package:get/get.dart';

import '../../features/dashboard/controllers/dashboard_controller.dart';
import '../../features/leave_plan_requests/controllers/leave_plan_requests_controller.dart';
import '../../features/leave_requests/controllers/leave_requests_controller.dart';
import '../../features/schedule/controllers/schedule_controller.dart';
import 'main_shell_controller.dart';

/// Merges the bindings of the four bottom-nav tabs (previously each a
/// standalone route with its own `Binding`) since they now all need to be
/// alive simultaneously behind an `IndexedStack`.
class MainShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainShellController());
    Get.lazyPut(
      () => DashboardController(
        leaveBalancesRepository: Get.find(),
        approvalsRepository: Get.find(),
      ),
    );
    Get.lazyPut<ScheduleController>(
      () => ScheduleController(scheduleRepository: Get.find()),
    );
    Get.lazyPut<LeaveRequestsController>(
      () => LeaveRequestsController(leaveRequestsRepository: Get.find()),
    );
    Get.lazyPut<LeavePlanRequestsController>(
      () =>
          LeavePlanRequestsController(leavePlanRequestsRepository: Get.find()),
    );
  }
}
