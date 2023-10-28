import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';

class HomeController extends GetxController {
  StudentController? studentController;
  UserController? userController;

  void changeStudentStatus() async {
    Get.toNamed("/change-status");
  }

  contactSchool() async {
    const number = '1234567890'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
