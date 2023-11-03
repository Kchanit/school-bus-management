import 'package:get/get.dart';
import 'package:school_bus/app/services/auth_service.dart';

class DriverEndController extends GetxController {
 final authService = AuthService();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    authService.saveState("driver-end");
  }

  @override
  void onClose() {
    super.onClose();
  }

}
