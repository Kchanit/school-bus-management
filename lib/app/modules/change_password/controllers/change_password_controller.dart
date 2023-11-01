import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/user_model.dart';

class ChangePasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxString errorMessage = ''.obs;
  final apiService = ApiService();

  saveData() async {
    User? currentUser = Get.find<UserController>().currentUser.value;
    errorMessage.value = '';
    var data = {
      'password': passwordController.text,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text,
    };
    print(data);
    final response = await apiService.putData(
        data, '/users/${currentUser!.id}/change-password');
    print(response['message']);
    if (response['success'] == true) {
      passwordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      Get.back();
      Get.snackbar('Success', response['message']);
    } else {
      errorMessage.value = response['message'];
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
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}
