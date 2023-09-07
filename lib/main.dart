import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/user_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  Get.put(UserController());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
