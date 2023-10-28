import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/user_model.dart';

class HomeController extends GetxController {
  StudentController? studentController;
  UserController? userController;
  RxList<User> users = <User>[].obs;

  void changeStudentStatus() async {
    Get.toNamed("/change-status");
  }

  // Future<Null> checkPreference() async{
  //     // get the device firebasetoken
  //     await Firebase.initializeApp();
  //     FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //     String? token = await firebaseMessaging.getToken();
  //     print("++++++++++++++++++++++");
  //     print('token ======> $token');
  //     // get current user data
  //     User? currentUser = Get.find<UserController>().currentUser.value;
  //     print('Current user ====> ${currentUser}');
  //     currentUser!.fbtoken = token;
      
  //     var data = {
  //       "fbtoken" : currentUser.fbtoken,
  //     };
  //     var response = await ApiService().putData(data, '/users/${currentUser.id}');

  //     if (response['success'] == true) {
  //       print('User Updated Successfully');
  //       print(response);
  //     } else {
  //       print('User Updated Failed');
  //       print(response['message']);
  //       Get.snackbar('Error', response['message']);
  //     }
  // }

  contactSchool() async {
    const number = '1234567890'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // get fire token after login
    // checkPreference();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    // get fire token after login
    // checkPreference();
  }
}
