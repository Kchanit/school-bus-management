import 'package:get/get.dart';

import '../controllers/change_status_controller.dart';

class ChangeStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeStatusController>(
      () => ChangeStatusController(),
    );
  }
}
