import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/widgets/driver/custom_driver_drawer.dart';
import '../controllers/reorder_student_controller.dart';
import 'package:school_bus/app/routes/app_pages.dart';

class ReorderStudentView extends GetView<ReorderStudentController> {
  const ReorderStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
                Get.toNamed(Routes.SETTING);
              },
            icon: const Icon(
              Icons.settings,
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
      // drawer: const CustomDriverDrawer(),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(
            bottom: 120.0,
          ),
          child: Column(
            children: [
              const Text(
                'ลำดับการส่ง',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'กดค้างและเลื่อน เพื่อเปลี่ยนแปลงลำดับ',
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_alt_rounded,
                    size: 18,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      controller.studentController.myStudents.length.toString())
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ReorderableListView(
                  onReorder: (oldIndex, newIndex) {
                    controller.reorder(oldIndex, newIndex);
                  },
                  children: controller.studentController.myStudents
                      .map(
                        (student) => ListTile(
                          key: ValueKey(student.id),
                          // leading: Text(e.id.toString()),
                          title: Text(
                            student.fullName,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          subtitle: Text('${student.address}'),
                          trailing: const Icon(Icons.drag_handle_rounded),
                        ),
                      )
                      .toList(),
                ),
              ),
              CupertinoButton.filled(
                  child: const Text('Confirm'),
                  onPressed: () {
                    controller.updateOrder();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
