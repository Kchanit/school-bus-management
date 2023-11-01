import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/modules/select_student/controllers/select_student_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterAddressController extends GetxController {
  User? currentUser;
  Student? student;
  RxString districtMessage = ''.obs;
  RxString streetMessage = ''.obs;
  Map<String, dynamic> address = {};
  var isLoading = false.obs;

  Future<void> registerData() async {
    isLoading.value = true;
    if (!validateAddress()) {
      isLoading.value = false;
      return;
    }
    final parentResponse = await _registerParent();
    print(parentResponse);
    final addressResponse = await _registerAddress();
    print(addressResponse);
    final enrollResponse = await _enrollStudent();
    print(enrollResponse);

    if (parentResponse['success'] && addressResponse['success']) {
      Get.snackbar('Success', 'User Registered Successfully');
      await Get.find<UserController>()
          .fetchStudent(Get.find<UserController>().currentUser.value!.id);
      Get.offAllNamed('/home');
    } else {
      final errorMessage = parentResponse['message'] ??
          addressResponse['message'] ??
          'Unknown error occurred';
      Get.snackbar('Error', 'Registration failed: $errorMessage');
    }
    isLoading.value = false;
  }

  _registerParent() async {
    final parentData = {
      "first_name": Get.find<RegisterController>().firstNameController.text,
      "last_name": Get.find<RegisterController>().lastNameController.text,
      "citizen_id": Get.find<RegisterController>().citizenIdController.text,
      "email": Get.find<RegisterController>().emailController.text,
      "password": Get.find<RegisterController>().passwordController.text,
      "role": "PARENT",
    };

    print("Sending parent data");
    print(parentData);

    var response = await ApiService().postData(parentData, '/register');
    print(response['message']);

    currentUser = User.fromJson(response['user']);
    Get.find<UserController>().setCurrentUser(currentUser!);
    return response;
  }

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

    var response = await ApiService().postData(addressData, '/addresses');
    print(response['message']);

    address = response['address'];
    return response;
  }

  _enrollStudent() async {
    final parent_id = currentUser!.id;
    final address_id = address['id'];
    final successfulEnrollments = <Student>[];
    final unsuccessfulEnrollments = <Map<String, dynamic>>[];
    for (final student
        in Get.find<SelectStudentController>().selectedStudents) {
      final studentData = {
        "student_id": student.id,
        "parent_id": parent_id,
        "address_id": address_id,
      };

      print("Enrolling student with ID: ${student.id}");
      print(studentData);

      var response =
          await ApiService().postData(studentData, '/students/enroll');
      print(response['message']);

      if (response['success']) {
        successfulEnrollments.add(student);
      } else {
        unsuccessfulEnrollments.add({
          "student": student,
          "message": response['message'],
        });
      }
    }

    _printEnrollmentResults(successfulEnrollments, unsuccessfulEnrollments);
  }

  void _printEnrollmentResults(List<Student> successfulEnrollments,
      List<Map<String, dynamic>> unsuccessfulEnrollments) {
    if (successfulEnrollments.isNotEmpty) {
      print('Successfully enrolled ${successfulEnrollments.length} students');
    }

    if (unsuccessfulEnrollments.isNotEmpty) {
      print('Failed to enroll ${unsuccessfulEnrollments.length} students.');

      for (final enrollment in unsuccessfulEnrollments) {
        final student = enrollment['student'];
        final errorMessage = enrollment['message'];
        print("Enrollment failed for student ${student.id}: $errorMessage");
      }
    }

    if (unsuccessfulEnrollments.isEmpty) {
      print("All students enrolled successfully");
    }
  }

  bool validateAddress() {
    if (Get.find<PickAddressController>().district.value == "") {
      districtMessage.value = "Please select district";
      return false;
    } else if (Get.find<PickAddressController>().street.value == "") {
      streetMessage.value = "Please select street";
      return false;
    }
    return true;
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
