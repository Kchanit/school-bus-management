import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';

import '../../modules/home/controllers/home_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.17,
            child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.amber),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 50,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      Get.find<UserController>().currentUser.value!.fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
          ),
          if (Get.find<UserController>().currentUser.value!.role == 'PARENT')
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(
                'Children',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              children: [
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: Get.find<StudentController>().myStudents.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        onTap: () {
                          Get.find<StudentController>().student.value =
                              Get.find<StudentController>().myStudents[index];
                          Get.back();
                        },
                        title: Text(
                          Get.find<StudentController>()
                              .myStudents[index]
                              .fullName,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          SizedBox(
            height: 10,
          ),
          ListTile(
              title: Text(
                'Contact School',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              // selected: _selectedIndex == 0,
              onTap: () {
                // _onItemTapped(0);
                Navigator.pop(context);
              },
              trailing: CircleAvatar(
                backgroundColor: Colors.amber.shade100,
                child: IconButton(
                  onPressed: () {
                    Get.find<HomeController>().contactSchool();
                  },
                  icon: const Icon(
                    Icons.phone_rounded,
                    color: Colors.brown,
                    size: 18,
                  ),
                ),
              )),
          ListTile(
            title: Text(
              'Setting',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            // selected: _selectedIndex == 1,
            onTap: () {
              Get.toNamed(Routes.SETTING);
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            // selected: _selectedIndex == 2,
            onTap: () {
              // _onItemTapped(2);
              AuthService().logout();
            },
          ),
        ],
      ),
    );
  }
}
