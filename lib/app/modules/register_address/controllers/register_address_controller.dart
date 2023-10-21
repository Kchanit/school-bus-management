import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/modules/register_student/controllers/register_student_controller.dart';
import 'package:school_bus/app/modules/select_student/controllers/select_student_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterAddressController extends GetxController {
  // final formKey = GlobalKey<FormState>();
  User? currentUser;
  Student? student;
  var address;
  var isLoading = false.obs;

  Future<void> registerData() async {
    isLoading.value = true;
    final parentResponse = await _registerParent();
    print(parentResponse);
    final addressResponse = await _registerAddress();
    print(addressResponse);
    final enrollResponse = await _enrollStudent();
    print(enrollResponse);

    if (parentResponse['success'] &&
        addressResponse['success'] &&
        enrollResponse['success']) {
      Get.snackbar('Success', 'User Registered Successfully');
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar(
          'Error', 'Registration failed: ${parentResponse['message']}');
    }

    isLoading.value = false;
  }

  // _registerEntity(data, String apiPath) async {
  //   try {
  //     final response = await ApiService().postData(data, apiPath);
  //     if (response['success'] == true) {
  //       return response;
  //     } else {
  //       return {'success': false, 'message': response['message']};
  //     }
  //   } catch (e) {
  //     return {'success': false, 'message': 'An error occurred.'};
  //   }
  // }

  _registerParent() async {
    final parentData = {
      "first_name": Get.find<RegisterController>().firstNameController.text,
      "last_name": Get.find<RegisterController>().lastNameController.text,
      "citizen_id": Get.find<RegisterController>().citizenIdController.text,
      "email": Get.find<RegisterController>().emailController.text,
      "password": Get.find<RegisterController>().passwordController.text,
      "role": "parent",
    };
    print("Sending parent data");
    print(parentData);
    // var response = await _registerEntity(parentData, '/register');
    var response = await ApiService().postData(parentData, '/register');
    print(response);
    if (response['success'] == false) {
      return Get.snackbar('Success', response['message']);
    }
    currentUser = User.fromJson(response['user']);
    Get.find<UserController>().setCurrentUser(currentUser!);
    return response;
  }

  // _registerStudent() async {
  //   String imageUrl = '';
  //   if (Get.find<RegisterController>().imageBytes.value != null) {
  //     imageUrl = await Get.find<RegisterStudentController>().saveImage();
  //   }

  //   List<int> students_id = Get.find<SelectStudentController>()
  //       .selectedStudents
  //       .map((student) => student.id)
  //       .toList();
  //   final studentData = {
  //     "students_id": students_id,
  //   };
  //   print("Sending student data");
  //   print(studentData);
  //   // var response = await _registerEntity(studentData, '/students');
  //   var response = await ApiService().postData(studentData, '/students');
  //   student = Student.fromJson(response['student']);
  //   Get.find<StudentController>().setMyStudent(student!);
  //   return response;
  // }

  _registerAddress() async {
    final addressData = {
      "home_address": Get.find<PickAddressController>().fullAddress.value,
      "home_latitude":
          Get.find<PickAddressController>().currentPosition!.latitude,
      "home_longitude":
          Get.find<PickAddressController>().currentPosition!.longitude,
      "district": Get.find<PickAddressController>().district.value,
      "road": Get.find<PickAddressController>().street.value,
      // "student_id": student!.id,
    };
    print("Sending address data");
    print(addressData);
    // var response = await _registerEntity(addressData, '/addresses');
    var response = await ApiService().postData(addressData, '/addresses');
    address = response['address'];
    print(response);
    return response;
  }

  _enrollStudent() async {
    final students_id = Get.find<SelectStudentController>()
        .selectedStudents
        .map((student) => student.id)
        .toList();
    final studentData = {
      "students_id": students_id,
      "parent_id": currentUser!.id,
      "address_id": address['id'],
    };

    print("Sending enroll data");
    print(studentData);
    var response = await ApiService().postData(studentData, '/students/enroll');
    print(response);
    return response;
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
