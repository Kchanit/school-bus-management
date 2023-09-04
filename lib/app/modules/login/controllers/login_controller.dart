import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    try {
      // Validate the Form
      if (!formKey.currentState!.validate()) {
        return;
      } else {
        formKey.currentState!.save();
      }

      // Payload for API request
      var data = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      // Make the login API request using your ApiService
      final response = await ApiService().postData(data, '/login');

      if (response['success'] == true) {
        // Handle successful login
        Get.snackbar('Success', response['message']);
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', response['message']);
        print(response['message']);
      }
    } catch (e) {
      Get.snackbar('Error2', e.toString());
      print(e.toString());
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
