import 'package:get/get.dart';
import 'package:school_bus/app/services/auth_service.dart';

class DriverEndController extends GetxController {
 final authService = AuthService();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    authService.saveState("driver-end");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
