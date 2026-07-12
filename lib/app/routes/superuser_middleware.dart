import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../features/auth/controllers/auth_controller.dart';
import 'app_routes.dart';

/// Gates admin-only routes. Runs after AuthMiddleware, so a missing session
/// is already handled by the time this checks the role.
class SuperuserMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isSuperuser =
        Get.find<AuthController>().currentUser.value?.isSuperuser ?? false;
    return isSuperuser ? null : const RouteSettings(name: Routes.dashboard);
  }
}
