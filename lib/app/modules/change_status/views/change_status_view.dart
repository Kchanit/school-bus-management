import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_status_controller.dart';

class ChangeStatusView extends GetView<ChangeStatusController> {
  const ChangeStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('School Bus'),
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
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: 
                          MaterialStateProperty.all(Colors.yellow),
                      // backgroundColor: controller.checkTime()
                      //     ? MaterialStateProperty.all(Colors.yellow)
                      //     : MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      controller.saveData();
                      
                    },
                    child: const Text('Confirm'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
