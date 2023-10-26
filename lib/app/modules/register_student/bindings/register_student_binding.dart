import 'package:get/get.dart';

import '../controllers/register_student_controller.dart';

class RegisterStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterStudentController>(
      () => RegisterStudentController(),
    );
  }
}
