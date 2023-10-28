import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/driver/custom_driver_drawer.dart';
import '../controllers/check_controller.dart';

class CheckView extends GetView<CheckController> {
  CheckView({Key? key}) : super(key: key);
  final RxBool checkboxValue1 = true.obs;
  final RxBool checkboxValue2 = true.obs;
  final RxBool checkboxValue3 = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
              ),
            ),
            const SizedBox(
              width: 6,
            )
          ],
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        drawer: const CustomDriverDrawer(),
        body: Column(children: [
          const Text(
            'เช็ครายชื่อเด็ก',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'กดเลือก รายชื่อที่ต้องการเช็ค',
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_alt_rounded,
                size: 18,
                color: Colors.black54,
              ),
              SizedBox(
                width: 10,
              ),
              Text('8/8')
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            return Column(
              children: [
                CheckboxListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  value: checkboxValue2.value,
                  onChanged: (bool? value) {
                    checkboxValue2.value = value!;
                  },
                  title: const Text('Student 1'),
                  subtitle: const Text(
                      'Longer supporting text to demonstrate how the text.'),
                ),
                const Divider(height: 0),
                CheckboxListTile(
                  value: checkboxValue3.value,
                  onChanged: (bool? value) {
                    checkboxValue3.value = value!;
                  },
                  title: const Text('Student 2'),
                  subtitle: const Text(
                      "Longer supporting text to demonstrate how the text."),
                  isThreeLine: true,
                ),
                const Divider(height: 0),
              ],
            );
          }),
          const SizedBox(
            height: 40,
          ),
          CupertinoButton.filled(
              child: const Text('Confirm'),
              onPressed: () {
                Get.toNamed('/map');
              })
        ]));
  }
}
