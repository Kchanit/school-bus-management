import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';

class DashboardController extends GetxController {
  RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
    // fetchUserData();
    // for firebase notification token
    checkPreference();
  }

  Future<Null> checkPreference() async{
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      print('token ======> $token');
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
    try {
      final response = await ApiService().getUserData();
      final userData = response['user'];
      users.add(User.fromJson(userData));
      // Now you can use userData as the logged-in user's data
      print('User Data: $userData');
    } catch (e) {
      print('Error fetching user data: $e');
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
