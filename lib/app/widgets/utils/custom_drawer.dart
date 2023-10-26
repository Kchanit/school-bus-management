import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bus/app/routes/app_pages.dart';

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
                    Container(
                        height: 46,
                        width: 46,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30))),
                    Text(
                      'FirstName LastName',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
          ),
          ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              'Children',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Child 1',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  'Child 2',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
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
          ListTile(
            title: Text(
              'Contact us',
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
