import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/models/student_model.dart';

import '../../../widgets/driver/custom_driver_drawer.dart';
import '../controllers/check_controller.dart';

class CheckView extends GetView<CheckController> {
  CheckView({Key? key}) : super(key: key);

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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people_alt_rounded,
                    size: 18,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      '${controller.checkedCount.value}/${controller.studentController.myStudents.length}'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.studentController.myStudents.length,
                  itemBuilder: (context, index) {
                    final Rx<Student> student =
                        controller.studentController.myStudents[index].obs;
                    // final isCheck = student.checked;
                    return ListTile(
                      title: Text(student.value.fullName),
                      trailing: Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            if (student.value.status.value ==
                                StudentStatus.CHECKED) {
                              return;
                            }
                            Get.defaultDialog(
                              title: "Confirm",
                              middleText: "Do you want to check this student?",
                              textConfirm: "Yes",
                              textCancel: "No",
                              onConfirm: () async {
                                if (await controller.updateStatus(
                                    student.value, StudentStatus.CHECKED)) {
                                  Get.back();
                                }
                                print(student.value.status.value);
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: student.value.status.value ==
                                    StudentStatus.CHECKED
                                ? Colors.grey
                                : null,
                          ),
                          child: Text(student.value.status.value ==
                                  StudentStatus.CHECKED
                              ? 'Checked'
                              : 'Check'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CupertinoButton.filled(
                  child: const Text('Confirm'),
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Confirm",
                      middleText: "Are you sure to confirm",
                      textConfirm: "Yes",
                      textCancel: "No",
                      onConfirm: () async {
                        controller.confirm();
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
