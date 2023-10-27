import 'package:get/get.dart';

import '../controllers/reorder_student_controller.dart';

class ReorderStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReorderStudentController>(
      () => ReorderStudentController(),
    );
  }
}
