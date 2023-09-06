import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooglemapController extends GetxController {
  late GoogleMapController _googleMapController;

  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(13.816510, 100.561789),
    zoom: 11.5,
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void moveCameraToInitialPosition() {
    if (_googleMapController != null) {
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
    }
  }
}

