import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/driver_end_controller.dart';

class DriverEndView extends GetView<DriverEndController> {
  const DriverEndView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Task Completed',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/thankYou.jpg",
              height: 220.0,
            ),
            const SizedBox(height: 20),
            Text(
              'The Task is completed.\nThank you for your service.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
