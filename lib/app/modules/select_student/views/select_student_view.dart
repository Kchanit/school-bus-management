import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';

import '../controllers/select_student_controller.dart';

class SelectStudentView extends GetView<SelectStudentController> {
  const SelectStudentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectStudentView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? CircularProgressIndicator() // Show loading indicator
          : Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 500, // Set the height of the carousel
                    viewportFraction:
                        0.8, // Set the fraction of the viewport to show
                    enableInfiniteScroll: false, // Enable infinite scrolling
                    enlargeCenterPage: true, // Enlarge the center item
                    onPageChanged: (index, reason) {
                      // Handle page change here
                    },
                  ),
                  // items: controller.tmpSelectedStudents.map((student) {
                  items: controller.myStudents.map((student) {
                    RxBool isSelected = false
                        .obs; // Set this to true if the student is selected
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            isSelected.value = !isSelected.value;

                            if (isSelected.value) {
                              controller.selectedStudents.add(student);
                            } else {
                              controller.selectedStudents.remove(student);
                            }
                          },
                          child: Container(
                            color: Colors.grey[400],
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: // Display student information
                                Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                student.imageUrl == null
                                    ? const Text('No image selected.')
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            NetworkImage(student.imageUrl!),
                                      ),
                                const SizedBox(height: 10),
                                Text(student.firstName),
                                Text(student.lastName),
                                const SizedBox(height: 10),
                                Obx(
                                  () => Icon(
                                    Icons.check_circle,
                                    color: (isSelected.value
                                        ? Colors.green
                                        : Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  // ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  buttonText: 'Next',
                  onPressed: () => Get.toNamed('/register-address'),
                ),
              ],
            )),
    );
  }
}
