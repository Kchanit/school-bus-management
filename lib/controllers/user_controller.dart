import 'package:get/get.dart';
import 'package:school_bus/models/user_model.dart';

class UserController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null);
  Rx<User?> myDriver = Rx<User?>(null);

  void setCurrentUser(User user) {
    currentUser.value = user;
  }
}
