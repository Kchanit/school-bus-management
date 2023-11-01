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
    // await userController.fetchStudent(userController.currentUser.value!.id);
    // await userController.fetchMyDriver(studentController!.student.value!.id);
    // print('Login Successful');
    Get.offAllNamed('/home');
  }

  handleDriverLogin() async {
    // await userController.fetchRoute(userController.currentUser.value!.id);
    // await userController.fetchRouteAddress(userController.currentUser.value!.id);
    Get.offAllNamed('/reorder-student');
  }

  // // Driver get students
  // Future<void> fetchRoute() async {
  //   final response =
  //       await apiService.getData('/routes/${currentUser!.id}/get-my-route');
  //   if (response['success'] == true) {
  //     final List<Student> students = (response['students'] as List)
  //         .map((student) => Student.fromJson(student))
  //         .toList();

  //     if (students.isNotEmpty) {
  //       students.sort((a, b) => a.order!.compareTo(b.order!));
  //       studentController!.myStudents.assignAll(students);
  //       for (var i = 0; i < studentController!.myStudents.length; i++) {
  //         print(studentController!.myStudents[i].fullName);
  //         print(studentController!.myStudents[i].order);
  //       }
  //       print("Students Amount: ${studentController!.myStudents.length}");
  //     } else {
  //       print("No students");
  //     }
  //   }
  // }

  // // Parent get driver
  // Future<void> fetchMyDriver(studentId) async {
  //   var response = await apiService.getData('/drivers/$studentId/get-driver');
  //   if (response['success'] == true) {
  //     userController.myDriver.value = User.fromJson(response['driver']);
  //     // Get the driver image
  //     userController.myDriver.value!.imageUrl =
  //         await userController.getDriverImageUrl();
  //   } else {
  //     // Get.snackbar('Error', response['message']);
  //     print(response['message']);
  //   }
  // }

  // // Driver get route address
  // fetchRouteAddress() async {
  //   final response = await apiService
  //       .getData('/routes/${currentUser!.id}/get-route-address');
  //   if (response['success'] == true) {
  //     final List<dynamic> routeAddressData = response['addresses'];

  //     // Create a map of order-to-address, assuming order is unique
  //     final Map<int, Map<String, dynamic>> routeAddresses = {};
  //     for (var i = 0; i < routeAddressData.length; i++) {
  //       routeAddresses[i] = {
  //         'address': routeAddressData[i]['home_address'].toString(),
  //         'latitude': routeAddressData[i]['home_latitude'],
  //         'longitude': routeAddressData[i]['home_longitude'],
  //       };
  //     }

  //     for (var i = 0; i < studentController!.myStudents.length; i++) {
  //       studentController!.myStudents[i].address =
  //           routeAddresses[i]!['address'];
  //       studentController!.myStudents[i].homeLatitude =
  //           double.tryParse(routeAddresses[i]!['latitude']);
  //       studentController!.myStudents[i].homeLongitude =
  //           double.tryParse(routeAddresses[i]!['longitude']);
  //     }
  //   }
  // }

  // // Parent get students
  // Future<void> fetchStudent(int id) async {
  //   final response = await apiService.getData('/students/$id/get-my-students');
  //   if (response['success'] == true) {
  //     final List<Student> studentsData = (response['students'] as List)
  //         .map((student) => Student.fromJson(student))
  //         .toList();
  //     print("Students Amount: ${studentsData.length}");
  //     studentController!.myStudents.assignAll(studentsData);
  //     if (studentController!.myStudents.isNotEmpty) {
  //       studentController!.student.value = studentController!.myStudents[0];
  //       print("Student: ${studentController!.student.value!.fullName} ");
  //     } else {
  //       print("No students");
  //     }
  //   } else {
  //     Get.snackbar('Error', response['message']);
  //   }
  // }
}
