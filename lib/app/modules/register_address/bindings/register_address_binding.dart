import 'package:get/get.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import '../controllers/register_address_controller.dart';

class RegisterAddressBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<RegisterAddressController>(
    //   () => RegisterAddressController(),
    // );
    Get.lazyPut<RegisterAddressController>(
      () => RegisterAddressController(
        Get.find<RegisterController>(), // Provide RegisterController here
      ),
  );
  }
}
