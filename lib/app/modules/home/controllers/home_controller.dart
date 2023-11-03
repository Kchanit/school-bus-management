import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final studentController = Get.find<StudentController>();
  final userController = Get.find<UserController>();
  final authService = AuthService();
  RxList<User> users = <User>[].obs;
  final RxInt index = 0.obs;
  final RxString time = ''.obs;
Rx<StudentStatus> status = StudentStatus.NONE.obs;

  var imagePath = "assets/images/seat.png".obs;

  List<String> imageList = [
    "assets/images/kids.png",
    "assets/images/bus-bd.gif",
    "assets/images/home.png",
  ];

  void getCurrentImagePath() {
    imagePath.value = imageList[index.value - 1];
  }

  void getCurrentTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat.Hm().format(now);
    time.value = formattedTime;
  }

  void initializeFirebaseMessaging() {
    print("FCM initialize");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received notification");
      print(message.notification!.title);
      print(message.notification!.body);
      String title = message.notification!.title ?? 'No title';
      String body = message.notification!.body ?? 'No body';
      showNotificationPopup(title, body);
    });
  }

  void changeStudentStatus() async {
    Get.toNamed("/change-status");
  }

  contactSchool() async {
    const number = '1234567890'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void showNotificationPopup(String title, String body) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              // index.value++;
              // print("add index");
              // print(index.value);
              // getCurrentImagePath();
              // print(imagePath.value);
              getCurrentTime();
              // print(time);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void refresh() async
  {
     final userId = await authService.getId();
    await userController.fetchParent(userId);
    await userController.fetchStudent(userId);
    await userController.fetchMyDriver(studentController.student.value!.id);
    status.value = Get.find<StudentController>().student.value!.status.value;
    print("refreshing!!!!!!!!!!!!!!!!!");
    print(status.value);
    print("====================================");
    chekstudentstatus();
  }

  void chekstudentstatus()
  { 
    if (status.value == StudentStatus.CHECKED) {
      print("index is 1");
      index.value = 1;
      imagePath.value =  "assets/images/kids.png";
    } else if (status.value == StudentStatus.ON_THE_WAY) {
      print("index is 2");
      index.value = 2;
      imagePath.value =  "assets/images/bus-bd.gif";
    }  else if (status.value == StudentStatus.ARRIVED_AT_HOME) {
      print("index is 3");
      index.value = 3;
      imagePath.value =  "assets/images/home.png";
    } else {
      print("NONE");
    }
  }

  handleParentEnd() async {
    Get.offAllNamed('/parent-end');
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentTime();
    initializeFirebaseMessaging();
  }

  @override
  void onReady() async {
    super.onReady();
    final userId = await authService.getId();
    if (userId != null) {
      await userController.fetchParent(userId);
      await userController.fetchStudent(userId);
      await userController.fetchMyDriver(studentController.student.value!.id);
      Rx<StudentStatus> status = Get.find<StudentController>().student.value!.status;
      chekstudentstatus();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
