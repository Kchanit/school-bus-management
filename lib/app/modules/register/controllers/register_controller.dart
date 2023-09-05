import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final registerformKey = GlobalKey<FormState>();
  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final count = 0.obs;
  var email=''; //???
 

  void registerUser() async {
    try {
      // if the form is "not" valid
      if (!registerformKey.currentState!.validate()) {
        return;
      }
      // if the form is valid 
      registerformKey.currentState!.save();
      
      // email = emailController.text;

      // Payload for API request
      var data = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      };

      final response = await ApiService().postData(data, '/register');

      if (response['success'] == true) {
        print('User Registered Successfully');
        print(response['message']);
        Get.snackbar('Success', response['message']);
        Get.offAllNamed('/dashboard');
      } else {
        print('User Registered Failed');
        print(response['message']);
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      print('User Registered Error');
      print(e.toString());
      Get.snackbar('Error2', e.toString());
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

  void increment() => count.value++;
}
