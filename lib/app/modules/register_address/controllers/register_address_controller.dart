import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/user_controller.dart';

class RegisterAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  User? currentUser;

  @override
  void onInit() {
    super.onInit();
  }

  registerData() async {
    var data = {
      "name": Get.find<RegisterController>().nameController.text,
      "email": Get.find<RegisterController>().emailController.text,
      "password": Get.find<RegisterController>().passwordController.text,
      "address": Get.find<PickAddressController>().draggedAddress.value,
      "home_latitude":
          Get.find<PickAddressController>().currentPosition!.latitude,
      "home_longitude":
          Get.find<PickAddressController>().currentPosition!.longitude,
    };
    print(data);

    var response = await ApiService().postData(data, '/register');
    if (response['success'] == true) {
      print('User Registered Successfully');
      print(response);
      currentUser = User.fromJson(response['user']);
      Get.find<UserController>().setCurrentUser(currentUser!);
      Get.snackbar('Success', response['message']);
      Get.offAllNamed('/dashboard');
    } else {
      print('User Registered Failed');
      print(response['message']);
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
