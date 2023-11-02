import 'package:get/get.dart';

import '../controllers/driver_end_controller.dart';

class DriverEndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverEndController>(
      () => DriverEndController(),
    );
  }
}
