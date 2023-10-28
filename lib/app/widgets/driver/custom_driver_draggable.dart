import 'package:flutter/material.dart';
import 'package:school_bus/app/widgets/driver/custom_driver_stepper.dart';

class CustomDriverDraggable extends StatelessWidget {
  const CustomDriverDraggable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        minChildSize: 0.2,
        maxChildSize: 0.9,
        initialChildSize: 0.2,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        CustomDriverStepper(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 16),
                          child: Column(
                            children: [
                              // Row(
                              //   children: [
                              //     Container(
                              //         height: 40,
                              //         width: 40,
                              //         margin: const EdgeInsets.only(right: 16),
                              //         decoration: BoxDecoration(
                              //             color: Colors.green,
                              //             borderRadius:
                              //                 BorderRadius.circular(30))),
                              //     Obx(
                              //       () => Text(Get.find<StudentController>()
                              //           .student
                              //           .value!
                              //           .fullName),
                              //     )
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Contact School'),
                                  CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.phone_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  IgnorePointer(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            height: 4,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}
