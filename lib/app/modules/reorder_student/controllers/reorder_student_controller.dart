import 'package:get/get.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';

class ReorderStudentController extends GetxController {
  UserController? userController;
  StudentController? studentController;

  void reorder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = studentController!.myStudents.removeAt(oldIndex);
    studentController!.myStudents.insert(newIndex, item);
  }

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
