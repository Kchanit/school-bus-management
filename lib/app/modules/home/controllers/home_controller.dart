import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';

class HomeController extends GetxController {
  final studentController = Get.find<StudentController>();
  final userController = Get.find<UserController>();
  final authService = AuthService();

  void changeStudentStatus() async {
    Get.toNamed("/change-status");
  }

  contactSchool() async {
    const number = '1234567890'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void onInit() async {
    super.onInit();
    final userId = await authService.getId();
    await userController.fetchParent(userId);
    await userController.fetchStudent(userId);
    await userController.fetchMyDriver(studentController.student.value!.id);
  }

  @override
  void onReady() {
    super.onReady();
  }
}
