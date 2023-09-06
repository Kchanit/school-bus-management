import 'package:get/get.dart';

import '../controllers/info2_controller.dart';

class Info2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Info2Controller>(
      () => Info2Controller(),
    );
  }
}
