import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/googlemap_controller.dart';

class GooglemapView extends StatelessWidget {
  final GooglemapController controller = Get.put(GooglemapController());

  GooglemapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GooglemapView'),
        centerTitle: true,
      ),
      body: GoogleMap(
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: controller.initialCameraPosition,
          onMapCreated: controller.onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        onPressed: () {
          controller.moveCameraToInitialPosition();
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
