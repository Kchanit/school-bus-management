import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/controllers/user_controller.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final StudentController? studentController = Get.find<StudentController>();
  final UserController userController = Get.find<UserController>();
  final apiService = ApiService();
  final authService = AuthService();
  final formKey = GlobalKey<FormState>();
  User? currentUser;
  RxString errorMessage = ''.obs;

  void login() async {
    if (formKey.currentState!.validate()) {
      var data = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      // Make login request
      print('Sending login request');
      final response = await apiService.postData(data, '/login');
      if (response['success'] == true) {
        // Store user data
        currentUser = User.fromJson(response['user']);
        userController.currentUser.value = currentUser;

        // Store access token
        final String accessToken = response['token'];
        authService.setToken(accessToken);
        authService.setRole(currentUser!.role);
        authService.setId(currentUser!.id.toString());

        print("Login as ${userController.currentUser.value!.fullName}");
        print(userController.currentUser.value!.role);

        emailController.clear();
        passwordController.clear();
        if (userController.currentUser.value!.role == 'PARENT') {
          await handleParentLogin();
        } else {
          await handleDriverLogin();
        }
      } else {
        errorMessage.value = response['message'];
        print(response['message']);
      }
    }
  }

  handleParentLogin() async {
    await userController.fetchStudent(userController.currentUser.value!.id);
    print(studentController!.student.value!.id);
    await userController.fetchMyDriver(studentController!.student.value!.id);
    // add firebase token
    checkPreference();
    print('Login Successful');
    Get.offAllNamed('/home');
  }

  handleDriverLogin() async {
    Get.offAllNamed('/reorder-student');
  }

  Future<Null> checkPreference() async {
    // get the device firebasetoken
    await Firebase.initializeApp();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print("++++++++++++++++++++++");
    print('token ======> $token');
    // get current user data
    User? currentUser = Get.find<UserController>().currentUser.value;
    print('Current user ====> ${currentUser}');
    currentUser!.fbtoken = token;

    var data = {
      "fbtoken": currentUser.fbtoken,
    };
    var response = await ApiService().putData(data, '/users/${currentUser.id}');

    if (response['success'] == true) {
      print('User Updated Successfully');
      print(response);
    } else {
      print('User Updated Failed');
      print(response['message']);
      Get.snackbar('Error', response['message']);
    }
  }
}
