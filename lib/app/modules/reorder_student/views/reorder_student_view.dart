import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/styles/space.dart';
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
        automaticallyImplyLeading: false,
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
                'Order of Delivery',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Press and hold, then drag to change the order',
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          subtitle: Text('${student.address}'),
                          trailing: const Icon(Icons.drag_handle_rounded),
                        ),
                      )
                      .toList(),
                ),
              ),
              Space.lg,
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
