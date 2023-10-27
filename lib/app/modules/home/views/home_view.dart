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
              onPressed: () {},
              icon: const Icon(Icons.person),
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
