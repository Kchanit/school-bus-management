import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/modules/test/controllers/test_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfigPlus.loadEnvVariables();
  Get.put(UserController());
  Get.put(RegisterController());
  Get.put(PickAddressController());
  Get.put(TestController());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder.put(() => TestController()),
    ),
  );
}
