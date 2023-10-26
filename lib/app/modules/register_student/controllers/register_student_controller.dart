import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_bus/app/services/cloud_api.dart';
import 'package:school_bus/models/user_model.dart';

class RegisterStudentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController citizenIdController = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();
  User? currentUser;

  Rx<File?> image = Rx<File?>(null);
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  String? imageName;
  final ImagePicker picker = ImagePicker();
  CloudApi? api;
  String? imageUrl;

  void getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      imageBytes.value = image.value!.readAsBytesSync();
      imageName = image.value!.path.split('/').last;
    } else {
      print('No image selected.');
    }
  }

  Future<String> saveImage() async {
    print("saving image");
    final response = await api!.save(imageName!, imageBytes.value!);
    imageUrl = response.downloadLink.toString();
    return imageUrl!;
  }

  showImageSourceSelection() {
    Get.bottomSheet(
      Container(
        decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            )),
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                getImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                getImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
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
