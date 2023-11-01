import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/widgets/home/custom_draggable.dart';
import 'package:school_bus/app/widgets/utils/custom_drawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print("Received notification");
    // print(message.notification!.title);
    // print(message.notification!.body);
    //   String title = message.notification!.title ?? 'No title';
    //   String body = message.notification!.body ?? 'No body';
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(title),
    //         content: Text(body),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Close'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.NOTIFICATION);
              },
              icon: const Icon(Icons.notifications_rounded),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.CHANGE_STATUS);
              },
              icon: const Icon(Icons.directions_bus_rounded),
            ),
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Image.asset(
                "assets/images/bus-bd.gif",
                height: 220.0,
                // width: MediaQuery.of(context).size.width,
              ),
            ),
            const CustomDraggable(),
          ],
        ));
  }
}
