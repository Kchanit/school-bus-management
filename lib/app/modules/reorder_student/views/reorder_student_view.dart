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
      body: Obx(
        () => ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            controller.reorder(oldIndex, newIndex);
          },
          children: controller.studentController!.myStudents
              .map(
                (e) => Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                  padding: EdgeInsets.all(16),
                  key: ValueKey(e),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.lightBlue),
                  child: Text(
                    e.fullName,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
