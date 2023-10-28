import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/home/controllers/home_controller.dart';
import 'package:school_bus/app/modules/login/controllers/login_controller.dart';
import 'package:school_bus/app/modules/pick_address/controllers/pick_address_controller.dart';
import 'package:school_bus/app/modules/register/controllers/register_controller.dart';
import 'package:school_bus/app/modules/register_address/controllers/register_address_controller.dart';
import 'package:school_bus/app/modules/register_student/controllers/register_student_controller.dart';
import 'package:school_bus/app/modules/reorder_student/controllers/reorder_student_controller.dart';
import 'package:school_bus/app/modules/test/controllers/test_controller.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfigPlus.loadEnvVariables();
  Get.put(StudentController());
  Get.put(UserController());
  Get.put(LoginController());
  Get.put(ApiService());
  Get.put(RegisterController());
  Get.put(RegisterStudentController());
  Get.put(RegisterAddressController());
  Get.put(PickAddressController());
  Get.put(HomeController());
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  Get.put(ReorderStudentController());
  Get.put(TestController());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
