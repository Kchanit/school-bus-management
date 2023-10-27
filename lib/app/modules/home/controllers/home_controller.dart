import 'package:get/get.dart';

class HomeController extends GetxController {
  void changeStudentStatus() async {
    Get.toNamed("/change-status");
  }
}
