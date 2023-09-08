import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: controller.fetchPosition,
                child: const Text('Get Location')),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/info2');
              },
              child: const Text('Go to Map'),
            )
          ],
        ),
      ),
    );
  }
}
