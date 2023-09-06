import 'package:get/get.dart';

import '../controllers/googlemap_controller.dart';

class GooglemapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GooglemapController>(
      () => GooglemapController(),
    );
  }
}
