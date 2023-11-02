import 'package:get/get.dart';

import '../controllers/parent_end_controller.dart';

class ParentEndBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentEndController>(
      () => ParentEndController(),
    );
  }
}
