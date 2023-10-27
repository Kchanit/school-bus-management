import 'package:get/get.dart';

import '../../../../controllers/student_controller.dart';
import '../../../../controllers/user_controller.dart';

class CheckController extends GetxController {
  UserController? userController;
  StudentController? studentController;

  @override
  void onInit() {
    super.onInit();
    userController = Get.find<UserController>();
    studentController = Get.find<StudentController>();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
