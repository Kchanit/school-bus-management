import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
          child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.REGISTER);
        },
        child: const Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      )),
    );
  }
}
