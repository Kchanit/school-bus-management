import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/controllers/user_controller.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString userRole = 'parent'.obs;
  User? currentUser;
  RxString errorMessage = ''.obs;

  void login() async {
    final UserController userController = Get.find<UserController>();
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
        // Store the token in the secure storage
        final String accessToken = response['token'];
        currentUser = User.fromJson(response['user']);
        userController.currentUser.value = currentUser;
        print("Login as ${userController.currentUser.value!.fullName}");
        final storage = FlutterSecureStorage();
        await storage.write(key: 'access_token', value: accessToken);

        if (userController.currentUser.value!.role == 'PARENT') {
          // Parent
          var student =
              await getStudent(userController.currentUser.value!.citizenId!);
          print("Student: ${student.value!.fullName} ");
          print('Login Successful');

          Get.snackbar('Success', response['message']);
          Get.offAllNamed('/home');
        } else {
          // Driver
          var students = await getRoute();
          Get.offAllNamed('/reorder-student');
        }
      } else {
        //display error message
        errorMessage.value = response['message'];
        print(response['message']);
      }
    }
  }

  getRoute() async {
    final data = {"driver_id": currentUser!.id};
    final response = await ApiService().postData(data, '/routes/get-my-route');
    if (response['success'] == true) {
      final List<dynamic> studentsData = response['students'];

      final List<Student> students = studentsData
          .map((student) => Student.fromJson(student as Map<String, dynamic>))
          .toList();

      if (students.isNotEmpty) {
        Get.find<StudentController>().myStudents.assignAll(students);
        return students;
      } else {
        print("No students");
      }
    }
    return null;
  }

  getStudent(String citizenId) async {
    final data = {"citizen_id": citizenId};
    final response =
        await ApiService().postData(data, '/students/get-my-students');
    if (response['success'] == true) {
      final List<Student> studentsData = (response['students'] as List)
          .map((student) => Student.fromJson(student))
          .toList();
      Get.find<StudentController>().myStudents.assignAll(studentsData);
      // Get.find<StudentController>().setMyStudents(studentsData);

      if (Get.find<StudentController>().myStudents.isNotEmpty) {
        Get.find<StudentController>().student.value =
            Get.find<StudentController>().myStudents[0];
        print("=====================================");
        print(Get.find<StudentController>().student.value!.fullName);
        return Get.find<StudentController>().student;
      } else {
        print("No students");
      }
    } else {
      Get.snackbar('Error', response['message']);
    }
  }
}
