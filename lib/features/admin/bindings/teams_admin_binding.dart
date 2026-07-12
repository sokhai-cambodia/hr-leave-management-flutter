import 'package:get/get.dart';

import '../controllers/teams_admin_controller.dart';

class TeamsAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamsAdminController>(
      () => TeamsAdminController(repository: Get.find(), usersRepository: Get.find()),
    );
  }
}
