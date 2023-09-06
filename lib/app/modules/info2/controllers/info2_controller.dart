import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_bus/user_controller.dart';

class Info2Controller extends GetxController {
  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition? cameraPosition;
  late LatLng defaultLatLng;
  late LatLng draggedLatlng;
  RxString draggedAddress = "".obs;
  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
    //set default latlng for camera position
    defaultLatLng = LatLng(11, 104);
    draggedLatlng = defaultLatLng;
    cameraPosition = CameraPosition(target: defaultLatLng, zoom: 17.5);

    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  saveData() {
    // UserController().currentUser.value.latitude = currentPosition!.latitude;
    // UserController().currentUser.value.longitude = currentPosition!.longitude;
  }

  //get address from dragged pin
  getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    // setState
    draggedAddress.value = addresStr;
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition!.latitude, currentPosition!.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    print("============================================");
    print("latitude: ${position.latitude}");
    print("longtitude: ${position.longitude}");
    print("============================================");
    await getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
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
