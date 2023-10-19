import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  void goNext() {
    // Validate the Form
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      formKey.currentState!.save();
    }
    Get.toNamed('/select-student');
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
