import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:http/http.dart' as http;


class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  User? currentUser;
  
  Rx<File?> image = Rx<File?>(null);
  final picker = ImagePicker();

  Future choiceImage() async {
    var pickerImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickerImage != null) {
      image.value = File(pickerImage.path);
    } else {
      Get.snackbar('Fail', 'No Image selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white);
    }
  }

  // Future uploadImage() async {
  //   final uri = Uri.parse("");
  //   var request = http.MultipartRequest('POST',uri);
  //   request.fields['name'] = nameController.text;
  //   var pic = await http.MultipartFile.fromPath("image", image!.path);
  //   request.files.add(pic);
  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     print('Image Uploaded');
  //   } else {
  //     print('Image Not Uploaded');
  //   }
  // }

  void register() {
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
