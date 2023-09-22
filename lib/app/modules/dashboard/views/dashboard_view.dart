import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  controller.users[index].image_url == null
                      ? const Text('No image selected.')
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(controller.users[index].image_url!),
                        ),
                  const SizedBox(height: 25),
                  Text(controller.users[index].name),
                  const SizedBox(height: 25),
                  Text('${controller.users[index].email} '),
                  const SizedBox(height: 25),
                  Text('${controller.users[index].address} '),
                  const SizedBox(height: 25),
                  Text(
                      'latitude: ${controller.users[index].home_latitude}, longitude: ${controller.users[index].home_longitude} '),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
