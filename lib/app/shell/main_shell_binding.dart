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
    // `fenix: true` on every entry here: form/detail screens for these tabs
    // are pushed with `Get.to()` and call `Get.find()` on these same
    // controllers. GetX links a dependency to whichever route was active
    // when `Get.find()` ran, not to every route that uses it - so closing
    // one of those pushed screens deletes the controller out from under the
    // still-alive shell (no reference counting across routes), and the next
    // `Get.find()` throws. `fenix: true` makes GetX lazily recreate the
    // instance instead of leaving it deleted.
    Get.lazyPut(() => MainShellController(), fenix: true);
    Get.lazyPut(
      () => DashboardController(
        leaveBalancesRepository: Get.find(),
        approvalsRepository: Get.find(),
      ),
      fenix: true,
    );
    Get.lazyPut<ScheduleController>(
      () => ScheduleController(scheduleRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<LeaveRequestsController>(
      () => LeaveRequestsController(leaveRequestsRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut<LeavePlanRequestsController>(
      () =>
          LeavePlanRequestsController(leavePlanRequestsRepository: Get.find()),
      fenix: true,
    );
  }
}
