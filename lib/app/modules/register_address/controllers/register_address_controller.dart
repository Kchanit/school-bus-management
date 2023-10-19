import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/modules/register_student/controllers/register_student_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  User? currentUser;
  Student? student;
  var isLoading = false.obs;

  Future<void> registerData() async {
    isLoading.value = true;
    final parentResponse = await _registerParent();
    print(parentResponse);
    final studentResponse = await _registerStudent();
    print(studentResponse);
    final addressResponse = await _registerAddress();
    print(addressResponse);

    if (parentResponse['success'] &&
        studentResponse['success'] &&
        addressResponse['success']) {
      Get.snackbar('Success', 'User Registered Successfully');
      Get.offAllNamed('/dashboard');
    } else {
      Get.snackbar(
          'Error', 'Registration failed: ${parentResponse['message']}');
    }

    isLoading.value = false;
  }

  _registerEntity(
    Map<String, dynamic> data,
    String apiPath,
  ) async {
    try {
      final response = await ApiService().postData(data, apiPath);
      if (response['success'] == true) {
        return response;
      } else {
        return {'success': false, 'message': response['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred.'};
    }
  }

  _registerParent() async {
    final parentData = {
      "first_name": Get.find<RegisterController>().firstNameController.text,
      "last_name": Get.find<RegisterController>().lastNameController.text,
      "citizen_id": Get.find<RegisterController>().citizenIdController.text,
      "email": Get.find<RegisterController>().emailController.text,
      "role": "parent",
      "password": Get.find<RegisterController>().passwordController.text,
    };
    print("Sending parent data");
    print(parentData);
    var response = _registerEntity(parentData, '/register');
    currentUser = User.fromJson(response['user']);
    Get.find<UserController>().setCurrentUser(currentUser!);
    return response;
  }

  _registerStudent() async {
    String imageUrl = '';
    if (Get.find<RegisterController>().imageBytes.value != null) {
      imageUrl = await Get.find<RegisterStudentController>().saveImage();
    }

    final studentData = {
      "first_name":
          Get.find<RegisterStudentController>().firstNameController.text,
      "last_name":
          Get.find<RegisterStudentController>().lastNameController.text,
      "student_number":
          Get.find<RegisterStudentController>().studentNumberController.text,
      "image_url": imageUrl,
      "parent_id": currentUser!.id,
    };
    print("Sending student data");
    print(studentData);
    var response = _registerEntity(studentData, '/students');
    student = Student.fromJson(response['student']);
    Get.find<StudentController>().setMyStudent(student!);
    return response;
  }

  _registerAddress() async {
    final addressData = {
      "address": Get.find<PickAddressController>().draggedAddress.value,
      "home_latitude":
          Get.find<PickAddressController>().currentPosition!.latitude,
      "home_longitude":
          Get.find<PickAddressController>().currentPosition!.longitude,
      "district": "testDistrict",
      "road": "testRoad",
      "student_id": student!.id,
    };
    print("Sending address data");
    print(addressData);
    var response = _registerEntity(addressData, '/addresses');
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
