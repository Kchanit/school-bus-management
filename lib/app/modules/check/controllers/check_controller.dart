import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/models/student_model.dart';

import '../../../../controllers/student_controller.dart';
import '../../../../controllers/user_controller.dart';

class CheckController extends GetxController {
  final userController = Get.find<UserController>();
  final studentController = Get.find<StudentController>();
  final authService = AuthService();
  RxInt checkedCount = 0.obs;
  Rx<StudentStatus> status = StudentStatus.NOT_CHECKED.obs;

  Future<bool> updateStatus(student, StudentStatus status) async {
    // noti
    final data = {
      "status": status.toString().split('.').last,
    };
    student.status.value = status;
    print(data);
    final response = await ApiService()
        .putData(data, '/students/${student.id}/update-status');
    if (response['success'] == true) {
      final student = Student.fromJson(response['student']);
      print(
          "Update status of ${student.fullName} to ${student.status.toString().split('.').last} successfully");
      sendNotification(student.id.toString(), "Schoolbus Notification",
          "Student: ${student.fullName} has boarded the bus.");
      return true;
    } else {
      sendNotification(student.value.id.toString(), "Schoolbus Notification",
          "Student: ${student.value.fullName} has NOT boarded the bus.");
      return false;
    }
  }

  void sendNotification(String student_id, String title, String body) async {
    print("SENDING NOTIFICATION+++++++++++++++++++++++++++++++++++++++");
    var data = {
      "student_id": student_id,
      "title": title,
      "body": body,
    };
    final response = await ApiService()
        .postData(data, '/sendNotification/{student_id}/{title}/{body}');
    if (response['success'] == true) {
      print(response);
      // Get.snackbar('Successfully send notification', response['message']);
    } else {
      print("respones__________________________________________________");
      print(response);
      // Get.snackbar('Error (sending notification)', response['message']);
    }
  }

  confirm() async {
    final students = studentController.myStudents;

    for (final student in students) {
      if (student.status.value == StudentStatus.CHECKED) {
        updateStatus(student, StudentStatus.ON_THE_WAY);
        student.status.value = StudentStatus.ON_THE_WAY;
        print("STUDENT VALUE");
        print(student.status.value);
        // Send notification to parent
      }
    }
    Get.toNamed('/map');
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    authService.saveState("check");
    // await userController.fetchRouteAddress(userId);
    final userId = await authService.getId();
    await userController.fetchRoute(userId);
    checkedCount = studentController.myStudents
        .where((student) => student.status.value == StudentStatus.CHECKED)
        .length
        .obs;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
