import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/user_controller.dart';
import 'package:http/http.dart' as http;

class RegisterAddressController extends GetxController {
  final formKey = GlobalKey<FormState>();
  User? currentUser;

  final RegisterController registerController;
  RegisterAddressController(this.registerController);

  @override
  void onInit() {
    super.onInit();
  }

  registerData() async {
    
    // if (registerController.image != null) {
      final uri = Uri.parse("http://192.168.1.114/api/register"); // Add your image upload URL here.
      var request = http.MultipartRequest('POST', uri);

      if (registerController.image.value != null) {
        var imageFile = registerController.image.value!;
        var pic = await http.MultipartFile.fromPath("image", imageFile.path);
        request.files.add(pic);
      }

      var responseImage = await request.send();
      print(Get.find<RegisterController>().image.value);
      if (responseImage.statusCode == 200) {
        // Image uploaded successfully
        print('Image Uploaded');
      } else {
        // Image upload failed
        print('Image Not Uploaded');
      }

    var data = {
      "name": Get.find<RegisterController>().nameController.text,
      "email": Get.find<RegisterController>().emailController.text,
      "password": Get.find<RegisterController>().passwordController.text,
      "image": Get.find<RegisterController>().image.value,
      "address": Get.find<PickAddressController>().draggedAddress.value,
      "home_latitude":
          Get.find<PickAddressController>().currentPosition!.latitude,
      "home_longitude":
          Get.find<PickAddressController>().currentPosition!.longitude,
    };
    print(data);

    var response = await ApiService().postData(data, '/register');
    if (response['success'] == true) {
      print('User Registered Successfully');
      print(response);
      currentUser = User.fromJson(response['user']);
      Get.find<UserController>().setCurrentUser(currentUser!);
      Get.snackbar('Success', response['message']);
      Get.offAllNamed('/dashboard');
    } else {
      print('User Registered Failed');
      print(response['message']);
      Get.snackbar('Error', response['message']);
    }
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
