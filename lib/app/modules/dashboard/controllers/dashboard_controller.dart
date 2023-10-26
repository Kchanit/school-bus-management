import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/controllers/user_controller.dart';

class DashboardController extends GetxController {
  RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    // fetchAllUsers();
    fetchUserData();

    //for FCM
    checkPreference();
    // notification();
  }

  // Future<Null> notification() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   if (message.notification != null) {
  //     print("Title: ${message.notification!.title}");
  //     print("Body: ${message.notification!.body}");
  //   }
  // });
  // }  

  Future<Null> checkPreference() async{
      // get the device firebasetoken
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      print("++++++++++++++++++++++");
      print('token ======> $token');
      // get current user data
      User? currentUser = Get.find<UserController>().currentUser.value;
      currentUser!.fbtoken = token;
      
      var data = {
        "fbtoken" : currentUser.fbtoken,
      };
      var response = await ApiService().putData(data, '/users/${currentUser.id}');

      if (response['success'] == true) {
        print('User Updated Successfully');
        print(response);
      } else {
        print('User Updated Failed');
        print(response['message']);
        Get.snackbar('Error', response['message']);
      }
  }
  

  Future<void> fetchAllUsers() async {
    final response = await ApiService().getData('/users');

    if (response['users'] != null) {
      // Parse the JSON response and convert it to a list of User objects
      List<dynamic> userJsonList = response['users'];
      List<User> userList =
          userJsonList.map((userJson) => User.fromJson(userJson)).toList();

      // Update the users list with the parsed data
      users.assignAll(userList);
    }
  }

Future<void> fetchUserData() async {
    // try {
    //   final response = await ApiService().getUserData();
    //   // final userData = response['user'];
    //   print(response['name']);
    //   // print(userData['name']);
    //   // print(userData['email']);
    //   users.add(User.fromJson(response));
    //   // print('User Data: $userData');
    // } catch (e) {
    //   print('Error fetching user data: $e');
    // }
    users.add(Get.find<UserController>().currentUser.value!);
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
