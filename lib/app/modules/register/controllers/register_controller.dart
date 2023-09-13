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
  TextEditingController nameController = TextEditingController();
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

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      imageBytes.value = image.value!.readAsBytesSync();
      imageName = image.value!.path.split('/').last;
    } else {
      print('No image selected.');
    }
  }

  Future<String> saveImage() async {
    final response = await api!.save(imageName!, imageBytes.value!);
    imageUrl = response.downloadLink.toString();
    print(imageUrl);
    return imageUrl!;
  }

  void goNext() {
    // Validate the Form
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      formKey.currentState!.save();
    }
    Get.toNamed('/register-address');
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
