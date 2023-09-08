import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/user_controller.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  User? currentUser;

  void registerUser() async {
    // Validate the Form
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      formKey.currentState!.save();
    }

    // Payload for API request
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    final response = await ApiService().postData(data, '/register');

    if (response['success'] == true) {
      print('User Registered Successfully');
      print(response);
      currentUser = User.fromJson(response['user']);
      print(currentUser!.name);
      Get.find<UserController>().setCurrentUser(currentUser!);
      Get.snackbar('Success', response['message']);
      Get.offAllNamed('/register-address');
    } else {
      print('User Registered Failed');
      print(response['message']);
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
