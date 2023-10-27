import 'package:get/get.dart';
import 'package:school_bus/app/modules/change_status/views/change_status_view.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/models/student_model.dart';

enum BusStatus { bus, yourself }

class ChangeStatusController extends GetxController {
  Student student = Get.find<StudentController>().student.value!;
  RxBool status = Get.find<StudentController>().student.value!.isTakingBus.obs;

  Rx<BusStatus> busStatus = BusStatus.bus.obs;

  saveData() async {
    if (busStatus.value == BusStatus.bus) {
      student.isTakingBus = true;
    } else {
      student.isTakingBus = false;
    }
    var data = {
      'student_id': student.id,
      'is_taking_bus': student.isTakingBus,
    };
    final response =
        await ApiService().postData(data, '/students/change-bus-status');
    if (response['success'] == true) {
      Get.snackbar('Success', response['message']);
      Get.offAllNamed("/home");
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
