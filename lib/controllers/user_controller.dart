import 'package:get/get.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/models/user_model.dart';

class UserController extends GetxController {
  Rx<User?> currentUser = Rx<User?>(null);
  Rx<User?> myDriver = Rx<User?>(null);

  void setCurrentUser(User user) {
    currentUser.value = user;
  }

  Future getDriverImageUrl() async {
    var response =
        await ApiService().getData('/drivers/${myDriver.value!.id}/get-image');
    if (response['success'] == true) {
      var imageUrl = response['image_url'];
      return imageUrl;
    }
    return null;
  }
}
