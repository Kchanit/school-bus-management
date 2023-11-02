import 'package:get/get.dart';
import 'package:school_bus/app/services/auth_service.dart';

class DriverHomeController extends GetxController {
 final authService = AuthService();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    authService.saveState("driver-home");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
