import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';

class ReorderStudentController extends GetxController {
  final userController = Get.find<UserController>();
  final studentController = Get.find<StudentController>();
  final authService = AuthService();

  void reorder(oldIndex, newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = studentController.myStudents.removeAt(oldIndex);
    studentController.myStudents.insert(newIndex, item);

    for (var i = 0; i < studentController.myStudents.length; i++) {
      studentController.myStudents[i].order = i + 1;
    }
    for (var i = 0; i < studentController.myStudents.length; i++) {
      print(studentController.myStudents[i].fullName);
      print(studentController.myStudents[i].order);
    }
  }

  void updateOrder() async {
    final data = {
      "driver_id": userController.currentUser.value!.id,
      "students": studentController.myStudents
          .map((e) => {"id": e.id, "order": e.order})
          .toList()
    };

    final response = await ApiService().putData(data, '/routes/update-order');
    if (response['success'] == true) {
      print("Route updated successfully");
      Get.snackbar('Success', response['message']);
      Get.offAllNamed('/map');
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    print("Reorder student controller ready");
    authService.saveState("reorder");
    final userId = await authService.getId();
    // await userController.fetchRoute(userId);
    print("Reorder student controller ready");
    studentController.myStudents.refresh();
    for (var i = 0; i < studentController.myStudents.length; i++) {
      print(studentController.myStudents[i].fullName);
    }
  }
}
