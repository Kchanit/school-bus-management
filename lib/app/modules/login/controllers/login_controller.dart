import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/controllers/user_controller.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString userRole = 'parent'.obs;

  void login() async {
    // Validate the Form
    if (formKey.currentState!.validate()) {
      // If the form is valid, proceed with login

      // Payload for API request
      var data = {
        'email': emailController.text,
        'password': passwordController.text,
        'role': userRole.value,
      };
      print('Sending login request');
      // Make the login API request using your ApiService
      final response = await ApiService().postData(data, '/login');
      if (response['success'] == true) {
        // Handle successful login
        final String accessToken = response['token'];
        User currentUser = User.fromJson(response['user']);
        Get.find<UserController>().setCurrentUser(currentUser);
        // Store the token in the secure storage
        final storage = FlutterSecureStorage();
        await storage.write(key: 'access_token', value: accessToken);

        Get.snackbar('Success', response['message']);
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar('Error', response['message']);
        print(response['message']);
      }
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
