import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class TestController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // _currentPosition = determinePosition();
    fetchPosition();
  }


  Future fetchPosition() async {
    try {
      // Check if location permission is granted
      bool hasLocationPermission = await _handleLocationPermission();
      if (!hasLocationPermission) {
        // Handle the case where location permission is not granted
        return;
      }

      // Fetch the current position
      Position position = await determinePosition();
      print("Latitude: ${position.latitude}");
      print("Longitude: ${position.longitude}");
      update(); // Notify listeners of the updated position
    } catch (e) {
      print('Error fetching position: $e');
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          'Location services are disabled. Please enable the services', '');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Location permissions are denied', '');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
          'Location permissions are permanently denied, we cannot request permissions.',
          '');
      return false;
    }
    return true;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
