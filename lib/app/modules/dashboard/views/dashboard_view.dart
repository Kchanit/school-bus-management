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
            return ListTile(
              title: Text(controller.users[index].name),
              subtitle: Text(
                  '${controller.users[index].email} | latitude: ${controller.users[index].home_latitude}, longitude: ${controller.users[index].home_longitude}'),
            );
          },
        ),
      ),
    );
  }
}
