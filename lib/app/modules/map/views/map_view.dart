import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/driver/custom_driver_drawer.dart';
import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Center(
        child: Text(
          'MapView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
