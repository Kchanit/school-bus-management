import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_bus/app/routes/app_pages.dart';
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
      'is_taking_bus': student.isTakingBus,
    };
    final response = await ApiService()
        .putData(data, '/students/${student.id}/change-bus-status');
    if (response['success'] == true) {
      Get.snackbar('Success', response['message']);
      if (student.isTakingBus) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.PARENT_END);
      }
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  checkTime() {
    final timeFormat = DateFormat("HH:mm");
    final now = DateTime.now();

    if (now.isAfter(timeFormat.parse("14:00"))) {
      return false;
    } else {
      return true;
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
