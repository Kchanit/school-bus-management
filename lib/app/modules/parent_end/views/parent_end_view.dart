import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';

import '../../../widgets/utils/custom_drawer.dart';
import '../controllers/parent_end_controller.dart';

class ParentEndView extends GetView<ParentEndController> {
  const ParentEndView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.CHANGE_STATUS);
            },
            icon: SvgPicture.asset(
              'assets/images/backpack3.svg',
              width: 20,
            ),
            style: const ButtonStyle(elevation: MaterialStatePropertyAll(1)),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Pick up your child',
                style: TextStyle(fontSize: 20),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/bus-bg.gif",
                    height: 220.0,
                  ),
                  // const SizedBox(height: 20),
                  const Text(
                    'Wishing you a safe journey',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
