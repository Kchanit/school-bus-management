import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                          if (_index.value < 6) {
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
            steps: <Step>[
              Step(
                title: const Text('Student1'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Student2'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Student3'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Student3'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Student3'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Student3'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Student3'),
                subtitle: const Text('Road, District'),
                content: _content(_index.value),
              ),
            ]));
  }
}

Widget _content(int index) {
  return const SizedBox();
}
