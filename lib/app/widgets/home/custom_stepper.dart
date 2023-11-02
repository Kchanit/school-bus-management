import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/home/controllers/home_controller.dart';

class CustomStepper extends StatelessWidget {
  
  CustomStepper({super.key});
  final RxInt _index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: <Widget>[],
                ),
              );
            },
            currentStep: Get.find<HomeController>().index.value,
            onStepTapped: (int index) {
              _index.value = index;
            },
            steps: <Step>[
              Step(
                title: const Text('Not on the bus'),
                subtitle: Text("Currently: ${Get.find<HomeController>().studentController.student.value!.fullName} has not arrived at the bus."),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Preparation'),
                subtitle: Text("Currently: ${Get.find<HomeController>().studentController.student.value!.fullName} has arrived at the bus and is preparing to depart."),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('On the way'),
                subtitle: Text("Currently: ${Get.find<HomeController>().studentController.student.value!.fullName} is departing and on the way home"),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Arrived'),
                subtitle: Text("Currently: ${Get.find<HomeController>().studentController.student.value!.fullName} has arrived at home."),
                content: _content(_index.value),
              )
            ]));
  }
}

Widget _content(int index) {
  return Column(
    // children: [
    //   Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Obx(() => Text(Get.find<HomeController>().time.value)),
            ],
          ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.people_rounded,
          //       size: 20,
          //     ),
          //     SizedBox(
          //       width: 6,
          //     ),
          //     Text('8'),
          //   ],
          // )
      //   ],
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     const Text('Your Queue : 3'),
      //     Text(index == 1 ? 'Current Queue : 5' : '')
      //   ],
      // )
    ],
  );
}
