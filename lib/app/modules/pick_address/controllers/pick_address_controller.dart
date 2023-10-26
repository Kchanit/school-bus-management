import 'package:get/get.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_bus/models/user_model.dart';
import 'package:school_bus/controllers/user_controller.dart';

class PickAddressController extends GetxController {
  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition? cameraPosition;
  late LatLng defaultLatLng;
  late LatLng draggedLatlng;
  RxString draggedAddress = "".obs;
  Position? currentPosition;
  User? currentUser;
  RxString district = "".obs;
  RxString street = "".obs;
  RxString fullAddress = "".obs;

  @override
  void onInit() async {
    super.onInit();
    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
    //set default latlng for camera position
    currentPosition = await _determineUserCurrentPosition();
    defaultLatLng =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    draggedLatlng = defaultLatLng;
    cameraPosition = CameraPosition(target: defaultLatLng, zoom: 17.5);
    currentUser = Get.find<UserController>().currentUser.value;
  }

  saveData() async {
    Get.toNamed("/register-address");
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    currentPosition = await _determineUserCurrentPosition();
    defaultLatLng =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    _gotoSpecificPosition(
        LatLng(currentPosition!.latitude, currentPosition!.longitude));
  }

  //get address from dragged pin
  getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    fullAddress.value =
        "${address.street}, ${address.subLocality}, ${address.administrativeArea} ${address.postalCode}";
    draggedAddress.value = fullAddress.value;
    district.value = address.subLocality!;
    street.value = address.street!;
    // when dragged pin, print info
    print("============================================");
    print("latitude: ${position.latitude}");
    print("longtitude: ${position.longitude}");
    print("address: ${draggedAddress.value}");
    print("full address: $fullAddress");
    print("district: ${address.subLocality}");
    print("street: ${address.street}");
    print("============================================");
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
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
