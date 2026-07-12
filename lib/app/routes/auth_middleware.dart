import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../features/auth/controllers/auth_controller.dart';
import 'app_routes.dart';

/// Redirects unauthenticated access away from routes that require a session.
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final hasSession = Get.find<AuthController>().currentUser.value != null;
    return hasSession ? null : const RouteSettings(name: Routes.login);
  }
}
