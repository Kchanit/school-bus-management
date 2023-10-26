import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomStepper extends StatelessWidget {
  CustomStepper({super.key});
  final RxInt _index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[],
                ),
              );
            },
            currentStep: _index.value,
            onStepTapped: (int index) {
              _index.value = index;
            },
            steps: <Step>[
              Step(
                title: const Text('Preparation'),
                subtitle: const Text('Content for Step 3'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('On the way'),
                subtitle: const Text('Content for Step 3'),
                content: _content(_index.value),
              ),
              Step(
                title: const Text('Arrived'),
                subtitle: const Text('Content for Step 3'),
                content: _content(_index.value),
              )
            ]));
  }
}

Widget _content(int index) {
  return Column(
    children: [
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text('12:00'),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.people_rounded,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('8'),
            ],
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Your Queue : 3'),
          Text(index == 1 ? 'Current Queue : 5' : '')
        ],
      )
    ],
  );
}
