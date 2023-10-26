import 'package:get/get.dart';

import '../controllers/select_student_controller.dart';

class SelectStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectStudentController>(
      () => SelectStudentController(),
    );
  }
}
