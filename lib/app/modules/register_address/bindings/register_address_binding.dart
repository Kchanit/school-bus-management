import 'package:get/get.dart';

import '../controllers/register_address_controller.dart';

class RegisterAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterAddressController>(
      () => RegisterAddressController(),
    );
  }
}
