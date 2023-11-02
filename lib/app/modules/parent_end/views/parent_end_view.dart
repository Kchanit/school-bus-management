import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        title: const Text(
          'School Bus',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/bus.bg",
              height: 220.0,
            ),
            const SizedBox(height: 20),
            Text(
              'Hope to see you again soon.',
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
