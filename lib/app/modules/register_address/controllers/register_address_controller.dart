import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/user_controller.dart';

class RegisterAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  User? currentUser;

  @override
  void onInit() {
    super.onInit();
    currentUser = Get.find<UserController>().currentUser.value;
  }

  updateData() async {
    currentUser!.home_latitude =
        Get.find<PickAddressController>().currentPosition!.latitude;
    currentUser!.home_longitude =
        Get.find<PickAddressController>().currentPosition!.longitude;
    currentUser!.address =
        Get.find<PickAddressController>().draggedAddress.value;
    var data = currentUser!.toJson();
    var response =
        await ApiService().putData(data, '/users/${currentUser!.id}');
    if (response['success'] == true) {
      print('User updated Successfully');
      Get.snackbar('Success', response['message']);
      Get.offAllNamed('/dashboard');
    } else {
      print('User update Failed');
      Get.snackbar('Error', response['message']);
    }
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
