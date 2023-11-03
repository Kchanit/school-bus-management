import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/styles/space.dart';
import 'package:school_bus/app/widgets/utils/custom_button.dart';
import '../controllers/select_student_controller.dart';

class SelectStudentView extends GetView<SelectStudentController> {
  const SelectStudentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/arrow-left.svg'),
          onPressed: () {
            Get.offAndToNamed(Routes.REGISTER);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select your children',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Space.sm,
                const Text(
                  'Swipe left to see more.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Space.lg,
          Obx(() => controller.isLoading.value
              ? const CircularProgressIndicator() // Show loading indicator
              : Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction:
                            0.8, // Set the fraction of the viewport to show
                        enableInfiniteScroll:
                            false, // Enable infinite scrolling
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 30),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ]),
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Space.sm,
                                    SvgPicture.asset(
                                      'assets/images/person-badge.svg',
                                      width: 40,
                                    ),
                                    Space.md,
                                    SizedBox(
                                      width: 180,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${student.firstName} ',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            student.lastName,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Space.md,
                                    Obx(() => isSelected.value
                                        ? SvgPicture.asset(
                                            'assets/images/check-circle-fill.svg',
                                            width: 25,
                                          )
                                        : SvgPicture.asset(
                                            'assets/images/check-circle.svg',
                                            width: 25,
                                          )),
                                  ]),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                      // ),
                    ),
                    Space.xl,
                    const SizedBox(height: 10),
                    CustomButton(
                      buttonText: 'Next',
                      onPressed: () => Get.toNamed('/register-address'),
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}
