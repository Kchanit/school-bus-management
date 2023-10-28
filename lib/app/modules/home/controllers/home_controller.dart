import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/user_model.dart';

class HomeController extends GetxController {
  StudentController? studentController;
  UserController? userController;

  void changeStudentStatus() async {
    Get.toNamed("/change-status");
  }

  void fetchMyDriver() async {
    var data = {
      "student_id": studentController!.student.value!.id,
    };

    var response = await ApiService().postData(data, '/drivers/get-driver');
    if (response['success'] == true) {
      userController!.myDriver.value = User.fromJson(response['data']);
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  @override
  void onInit() {
    super.onInit();

  }
}
