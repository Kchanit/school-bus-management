import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/app/services/cloud_api.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController citizenIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  User? currentUser;

  Rx<File?> image = Rx<File?>(null);
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  String? imageName;
  final ImagePicker picker = ImagePicker();
  CloudApi? api;
  String? imageUrl;
  RxString emailError = ''.obs;
  RxString citizenIdError = ''.obs;

  void goNext() async {
    // Validate the Form
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      formKey.currentState!.save();
    }

    var data = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'citizen_id': citizenIdController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'confirmPassword': confirmPasswordController.text,
      'imageUrl': imageUrl,
    };

    var response = await ApiService().postData(data, '/register/validate');
    if (response['success'] == true) {
      // Registration was successful, navigate to the next screen or show a success message.
      print("validate success");
      Get.toNamed('/select-student');
    } else {
      if (response.containsKey('errors') && response['errors'] is Map) {
        final errors = response['errors'] as Map;
        print(errors);
        if (errors.containsKey('email')) {
          emailError.value = errors['email'];
        }
        if (errors.containsKey('citizen_id')) {
          citizenIdError.value = errors['citizen_id'];
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    rootBundle.loadString('assets/credentials.json').then((json) {
      api = CloudApi(json);
    });
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
