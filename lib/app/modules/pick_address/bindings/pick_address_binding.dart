import 'package:get/get.dart';

import '../controllers/pick_address_controller.dart';

class PickAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickAddressController>(
      () => PickAddressController(),
    );
  }
}
