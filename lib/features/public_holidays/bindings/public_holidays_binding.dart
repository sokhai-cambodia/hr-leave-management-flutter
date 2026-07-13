import 'package:get/get.dart';

import '../controllers/public_holidays_controller.dart';

class PublicHolidaysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicHolidaysController>(
      () => PublicHolidaysController(publicHolidaysRepository: Get.find()),
    );
  }
}
