import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/styles/space.dart';
import 'package:school_bus/app/styles/stye.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';

import '../controllers/change_status_controller.dart';

class ChangeStatusView extends GetView<ChangeStatusController> {
  const ChangeStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'School Bus',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.black),
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close)),
          centerTitle: true,
        ),
        body: Obx(
          () => Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/road.png',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'เลือกรูปแบบการกลับ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Can be changed until 14:00',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '* ถ้าไม่เลือกการกลับจะเป็นรูปแบบ By School Bus *',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  RadioListTile<BusStatus>(
                    title: const Text('By School Bus'),
                    value: BusStatus.bus,
                    selected: false,
                    groupValue: controller.status.value == true
                        ? BusStatus.bus
                        : BusStatus.yourself,
                    onChanged: (BusStatus? value) {
                      controller.busStatus.value = value!;
                      controller.status.value = true;
                    },
                  ),
                  RadioListTile<BusStatus>(
                    title: const Text('กลับด้วยตัวเอง'),
                    value: BusStatus.yourself,
                    groupValue: controller.status.value == true
                        ? BusStatus.bus
                        : BusStatus.yourself,
                    onChanged: (BusStatus? value) {
                      controller.busStatus.value = value!;
                      controller.status.value = false;
                    },
                  ),
                  Space.lg,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: CustomButton(
                      buttonText: 'Confirm',
                      onPressed: () {
                        controller.saveData();
                      },
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     backgroundColor:
                  //         MaterialStateProperty.all(Style.primaryColor),
                  //     // backgroundColor: controller.checkTime()
                  //     //     ? MaterialStateProperty.all(Colors.yellow)
                  //     //     : MaterialStateProperty.all(Colors.grey),
                  //   ),
                  //   onPressed: () {
                  //     controller.saveData();
                  //   },
                  //   child: const Text('Confirm'),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
