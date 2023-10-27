import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_status_controller.dart';

enum SingingCharacter { bus, yourself }

class ChangeStatusView extends GetView<ChangeStatusController> {
  const ChangeStatusView({Key? key}) : super(key: key);

  static Rx<SingingCharacter> _character = SingingCharacter.bus.obs;

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
                  RadioListTile<SingingCharacter>(
                    title: const Text('By School Bus'),
                    value: SingingCharacter.bus,
                    groupValue: _character.value,
                    onChanged: (SingingCharacter? value) {
                      _character.value = value!;
                    },
                  ),
                  RadioListTile<SingingCharacter>(
                    title: const Text('กลับด้วยตัวเอง'),
                    value: SingingCharacter.yourself,
                    groupValue: _character.value,
                    onChanged: (SingingCharacter? value) {
                      _character.value = value!;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber)),
                      onPressed: () {
                        // Get.find<HomeController>().changeStudentStatus();
                      },
                      child: const Text('Confirm'))
                ],
              ),
            ),
          ),
        ));
  }
}
