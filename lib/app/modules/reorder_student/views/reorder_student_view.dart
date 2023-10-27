import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reorder_student_controller.dart';

class ReorderStudentView extends GetView<ReorderStudentController> {
  const ReorderStudentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReorderStudentView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  controller.reorder(oldIndex, newIndex);
                },
                children: controller.studentController!.myStudents
                    .map(
                      (e) => Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 8),
                        padding: const EdgeInsets.all(16),
                        key: ValueKey(e),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: Colors.lightBlue),
                        child: Text(
                          e.fullName,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                controller.updateOrder();
              },
              child: const Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }
}
