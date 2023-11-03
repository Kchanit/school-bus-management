import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_bus/app/widgets/driver/custom_driver_draggable.dart';
import 'package:school_bus/app/widgets/driver/custom_map.dart';
import '../../../widgets/driver/custom_driver_drawer.dart';
import '../controllers/map_controller.dart';
import 'package:school_bus/app/routes/app_pages.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        drawer: const CustomDriverDrawer(),
        body: const Stack(
          children: [CustomMap(), CustomDriverDraggable()],
        ));
  }
}