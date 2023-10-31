import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/modules/map/controllers/map_controller.dart';

class CustomDriverStepper extends StatelessWidget {
  CustomDriverStepper({super.key});
  final RxInt _index = 0.obs;

  @override
  Widget build(BuildContext context) {

    // final mapController = Get.find<MapController>();
    // List<Step> steps = mapController.steps.toList();
    // int currentStepValue = steps.length;
    // _index.value = currentStepValue;
    
    return Obx(() => Stepper(
            physics: const NeverScrollableScrollPhysics(),
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          if (_index.value < Get.find<MapController>().studentController!.myStudents.length - 1){
                            _index.value += 1;
                          }
                           Get.find<MapController>().deleteMarker();
                        },
                        child: Text('Finish ${_index.value}')),
                    const Text('15:00   '),
                  ],
                ),
              );
            },
            currentStep: _index.value,
            onStepTapped: (int index) {
              _index.value = index;
            },
            // steps: Get.find<MapController>().steps.toList(),

            steps: Get.find<MapController>().studentController!.myStudents
                      .map(
                        (e) => Step(
                          title: Text('${e.fullName}'),
                          subtitle: Text('${e.homeLatitude}'),
                          content: Text('${e.homeLongitude}'),
                        ),
                      )
                      .toList(),
                ),

            // steps: <Step>[
            //   Step(
            //     title: const Text('Student1'),
            //     subtitle: const Text('Road, District'),
            //     content: _content(_index.value),
            //   ),
            );
  }
}

Widget _content(int index) {
  return const SizedBox();
}
