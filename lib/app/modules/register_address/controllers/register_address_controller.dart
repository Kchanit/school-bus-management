import 'package:get/get.dart';
import 'package:school_bus/app/modules/login/controllers/login_controller.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/modules/select_student/controllers/select_student_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterAddressController extends GetxController {
  // final formKey = GlobalKey<FormState>();
  User? currentUser;
  Student? student;
  RxString districtMessage = ''.obs;
  RxString streetMessage = ''.obs;

  var address;
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
      var student = await Get.find<LoginController>()
          .getStudent(Get.find<UserController>().currentUser.value!.citizenId!);
      print("Student: ${student.value!.fullName} ");
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
    final parent_id = currentUser!.id;
    final address_id = address['id'];
    final successfulEnrollments = [];
    final unsuccessfulEnrollments = [];
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
      print(response);

      if (response['success']) {
        successfulEnrollments.add(student);
      } else {
        unsuccessfulEnrollments.add({
          "student": student,
          "message": response['message'],
        });
      }
    }
    handleSuccessfulEnrollments(successfulEnrollments);
    handleUnsuccessfulEnrollments(unsuccessfulEnrollments);
    print("All students enrolled successfully");
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

  void handleSuccessfulEnrollments(List<dynamic> successfulEnrollments) {
    if (successfulEnrollments.isNotEmpty) {
      // Display a success message for the students who were enrolled successfully.
      Get.snackbar(
        'Success',
        'Successfully enrolled ${successfulEnrollments.length} students',
      );
    }
  }

  void handleUnsuccessfulEnrollments(List<dynamic> unsuccessfulEnrollments) {
    if (unsuccessfulEnrollments.isNotEmpty) {
      for (final enrollment in unsuccessfulEnrollments) {
        final student = enrollment['student'];
        final errorMessage = enrollment['error_message'];

        // Handle the unsuccessful enrollment.
        print("Enrollment failed for student ${student.id}: $errorMessage");
        // Display an error message to the user.
        Get.snackbar(
          'Error',
          'Enrollment failed for student ${student.id}: $errorMessage',
        );
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
