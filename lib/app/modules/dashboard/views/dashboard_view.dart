import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        String title = message.notification!.title ?? 'No title';
        String body = message.notification!.body ?? 'No body';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  controller.users[index].imageUrl == null
                      ? const Text('No image selected.')
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(controller.users[index].imageUrl!),
                        ),
                  const SizedBox(height: 25),
                  Text(controller.users[index].firstName),
                  const SizedBox(height: 25),
                  Text('${controller.users[index].email} '),
                  // const SizedBox(height: 25),
                  // Text('${controller.users[index].address} '),
                  // const SizedBox(height: 25),
                  // Text(
                  //     'latitude: ${controller.users[index].home_latitude}, longitude: ${controller.users[index].home_longitude} '),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
