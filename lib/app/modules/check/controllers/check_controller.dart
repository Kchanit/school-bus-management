import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/student_model.dart';

import '../../../../controllers/student_controller.dart';
import '../../../../controllers/user_controller.dart';

class CheckController extends GetxController {
  UserController? userController;
  StudentController? studentController;
  RxInt checkedCount = 0.obs;
  Rx<StudentStatus> status = StudentStatus.NOT_CHECKED.obs;

  Future<bool> updateStatus(Rx<Student> student, StudentStatus status) async {
    final data = {
      "status": status.toString().split('.').last,
    };
    student.value.status.value = status;
    print(data);
    final response = await ApiService()
        .putData(data, '/students/${student.value.id}/update-status');
    if (response['success'] == true) {
      final student = Student.fromJson(response['student']);
      print(
          "Update status of ${student.fullName} to ${student.status.toString().split('.').last} successfully");
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    userController = Get.find<UserController>();
    studentController = Get.find<StudentController>();
    checkedCount = studentController!.myStudents
        .where((student) => student.status.value == StudentStatus.CHECKED)
        .length
        .obs;
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