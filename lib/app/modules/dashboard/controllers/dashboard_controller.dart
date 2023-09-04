import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';

class DashboardController extends GetxController {
  RxList<User> users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    ApiService apiService = ApiService();
    final response = await apiService.getData('/users');

    if (response['users'] != null) {
      // Parse the JSON response and convert it to a list of User objects
      List<dynamic> userJsonList = response['users'];
      List<User> userList =
          userJsonList.map((userJson) => User.fromJson(userJson)).toList();

      // Update the users list with the parsed data
      users.assignAll(userList);
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
