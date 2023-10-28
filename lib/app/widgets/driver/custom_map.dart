import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_bus/app/modules/map/controllers/map_controller.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MapController(),
      builder: (controller) => controller.currentLocation == null
          ? const Center(
              child: Text('Loading...'),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(controller.currentLocation!.latitude!,
                      controller.currentLocation!.longitude!),
                  zoom: 14.5),
              polylines: {
                Polyline(
                    polylineId: const PolylineId('route'),
                    points: controller.polylineCoordinates,
                    color: Colors.blue,
                    width: 6)
              },
              markers: {
                Marker(
                    markerId: const MarkerId("currentLocation"),
                    // icon: controller.currentLocationIcon,
                    position: LatLng(controller.currentLocation!.latitude!,
                        controller.currentLocation!.longitude!)),
                Marker(
                    markerId: const MarkerId("source"),
                    position: controller.sourceLocation),
                Marker(
                    markerId: const MarkerId("destination"),
                    position: controller.destination),
              },
              // onMapCreated: (mapController) {
              //   controller.controller.complete(mapController);
              // },
            ),
    );
  }
}
