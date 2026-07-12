import 'package:get/get.dart';

import '../controllers/public_holidays_admin_controller.dart';

class PublicHolidaysAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicHolidaysAdminController>(
      () => PublicHolidaysAdminController(repository: Get.find()),
    );
  }
}
