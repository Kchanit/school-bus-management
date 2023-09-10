import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: controller.cameraPosition ??
                  const CameraPosition(
                    target: LatLng(13.8, 100.5),
                    zoom: 17.5,
                  ),
              onMapCreated: (GoogleMapController ggController) {
                if (!controller.googleMapController.isCompleted) {
                  controller.googleMapController.complete(ggController);
                }
              },
              markers: {
                if (controller.origin != null) controller.origin!,
                if (controller.destination != null) controller.destination!,
              },
              polylines: controller.polylines,
            ),
          ),
          // Button
          Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ElevatedButton(
                  child: const Text('Start Trip'),
                  onPressed: () => controller.initialize(),
                ),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Theme.of(context).primaryColor,
        // foregroundColor: Colors.black,
        onPressed: () {
          if (controller.googleMapController.isCompleted) {
            controller.googleMapController.future.then((con) {
              con.animateCamera(
                CameraUpdate.newCameraPosition(controller.cameraPosition!),
              );
            });
          }
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
