import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/api_response.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/user_controller.dart';
import 'package:http/http.dart' as http;

class RegisterAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  User? currentUser;

  final RegisterController registerController;
  RegisterAddressController(this.registerController);

  final GetConnect _connect = GetConnect(
      // the request will fail if it takes more than 10 seconds
      // you can use another value if you like
      timeout: const Duration(seconds: 10),
);


  @override
  void onInit() {
    super.onInit();
  }

  registerData() async {

    // ApiResponse responses = await ApiService().updateUser(ApiService().getStringImage(Get.find<RegisterController>().image.value));

    var data = {
      "name": Get.find<RegisterController>().nameController.text,
      "email": Get.find<RegisterController>().emailController.text,
      "password": Get.find<RegisterController>().passwordController.text,
      "image" : ApiService().getStringImage(Get.find<RegisterController>().image.value),
      "address": Get.find<PickAddressController>().draggedAddress.value,
      "home_latitude":
          Get.find<PickAddressController>().currentPosition!.latitude,
      "home_longitude":
          Get.find<PickAddressController>().currentPosition!.longitude,
    };
    print(Get.find<RegisterController>().image.value);
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
