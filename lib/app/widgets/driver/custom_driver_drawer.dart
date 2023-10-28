import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';

class CustomDriverDrawer extends StatelessWidget {
  const CustomDriverDrawer({super.key});

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
                    Icon(
                      Icons.account_circle_rounded,
                      size: 46,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      Get.find<UserController>().currentUser.value!.fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
          ),
          ListTile(
            title: Text(
              'Check',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              // _onItemTapped(0);
              Get.toNamed(Routes.CHECK);
            },
          ),
          ListTile(
            title: Text(
              'Route',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            // selected: _selectedIndex == 0,
            onTap: () {
              // _onItemTapped(0);
              Get.toNamed(Routes.REORDER_STUDENT);
            },
          ),
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
          ),
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
              Get.toNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
