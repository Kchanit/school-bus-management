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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final StudentController? studentController = Get.find<StudentController>();
  final UserController userController = Get.find<UserController>();
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
      final response = await ApiService().postData(data, '/login');
      if (response['success'] == true) {
        final String accessToken = response['token'];
        currentUser = User.fromJson(response['user']);
        userController.currentUser.value = currentUser;
        print("Login as ${userController.currentUser.value!.fullName}");

        // Store access token
        final storage = FlutterSecureStorage();
        await storage.write(key: 'access_token', value: accessToken);

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
    await fetchStudent(userController.currentUser.value!.citizenId!);
    await fetchMyDriver(studentController!.student.value!.id);
    print('Login Successful');
    Get.offAllNamed('/home');
  }

  handleDriverLogin() async {
    await fetchRoute();
    Get.offAllNamed('/reorder-student');
  }

  Future<void> fetchRoute() async {
    final data = {"driver_id": currentUser!.id};
    final response = await ApiService().postData(data, '/routes/get-my-route');
    if (response['success'] == true) {
      // final List<dynamic> studentsData = response['students'];

      // final List<Student> students = studentsData
      //     .map((student) => Student.fromJson(student as Map<String, dynamic>))
      //     .toList();

      final List<Student> students = (response['students'] as List)
          .map((student) => Student.fromJson(student as Map<String, dynamic>))
          .toList();

      if (students.isNotEmpty) {
        studentController!.myStudents.assignAll(students);
        print("Students Amount: ${studentController!.myStudents.length}");
      } else {
        print("No students");
      }
    }
  }

  Future<void> fetchMyDriver(studentId) async {
    var data = {"student_id": studentId};

    var response = await ApiService().postData(data, '/drivers/get-driver');
    if (response['success'] == true) {
      userController.myDriver.value = User.fromJson(response['driver']);
      // Get the driver image
      userController.myDriver.value!.imageUrl =
          await userController.getDriverImageUrl();
    } else {
      Get.snackbar('Error', response['message']);
    }
  }

  Future<void> fetchStudent(String citizenId) async {
    final data = {"citizen_id": citizenId};
    final response =
        await ApiService().postData(data, '/students/get-my-students');
    if (response['success'] == true) {
      final List<Student> studentsData = (response['students'] as List)
          .map((student) => Student.fromJson(student))
          .toList();
      studentController!.myStudents.assignAll(studentsData);
      if (studentController!.myStudents.isNotEmpty) {
        studentController!.student.value = studentController!.myStudents[0];
        print("Student: ${studentController!.student.value!.fullName} ");
      } else {
        print("No students");
      }
    } else {
      Get.snackbar('Error', response['message']);
    }
  }
}
