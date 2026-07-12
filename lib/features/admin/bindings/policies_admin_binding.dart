import 'package:get/get.dart';

import '../controllers/policies_admin_controller.dart';

class PoliciesAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PoliciesAdminController>(
      () => PoliciesAdminController(repository: Get.find()),
    );
  }
}
