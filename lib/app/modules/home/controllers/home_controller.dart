import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/models/student_model.dart';

class HomeController extends GetxController {
  Student student = Get.find<StudentController>().student.value!;

  void test() {
    // print(StudentController().myStudent![0]);
  }

  void changeStudentStatus() async {
    student.isTakingBus = !student.isTakingBus;
    print(Get.find<StudentController>().student.value!.isTakingBus);
    var data = {
      'student_id': student.id,
      'is_taking_bus': student.isTakingBus,
    };
    final response =
        await ApiService().postData(data, '/students/change-bus-status');
    if (response['success'] == true) {
      Get.snackbar('Success', response['message']);
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  @override
  void onInit() {
    super.onInit();
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
