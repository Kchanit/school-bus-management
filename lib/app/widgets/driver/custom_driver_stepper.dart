import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_bus/app/modules/map/controllers/map_controller.dart';

class CustomDriverStepper extends StatelessWidget {
  CustomDriverStepper({super.key});
  final RxInt _index = 0.obs;

  @override
  Widget build(BuildContext context) {
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
                          } else {
                            Get.find<MapController>().handleDriverHome();
                          }
                           Get.find<MapController>().deleteMarker();
                        },
                        child: Text('Finish')),
                  ],
                ),
              );
            },
            currentStep: _index.value,
            onStepTapped: (int index) {
              _index.value = index+1;
            },

            steps: Get.find<MapController>().studentController!.myStudents
                      .map(
                        (e) => Step(
                          title: Text('${e.fullName}'),
                          subtitle: Text('${e.address}'),
                          content: Text(''),
                        ),
                      )
                      .toList(),
                ),
            );
  }
}

Widget _content(int index) {
  return const SizedBox();
}
