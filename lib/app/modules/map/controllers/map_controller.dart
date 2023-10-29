import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class MapController extends GetxController {
  final Completer<GoogleMapController> controller = Completer();

  StudentController? studentController;

  LatLng sourceLocation = LatLng(13.8476, 100.57);
  LatLng destination = LatLng(13.8202, 100.564);

  List<Marker> markers = [];

  List<LatLng> polylineCoordinates = [];
  late Rx<LocationData?> currentLocation = Rx<LocationData?>(LocationData.fromMap({
    "latitude": 13.8476, // Default latitude value
    "longitude": 100.57, // Default longitude value
  }));

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation.value = location;
      // print("current location data = ${currentLocation}");
      update();
    });

    GoogleMapController googleMapController = await controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation.value = newLoc;
      print("yo it changing = ${currentLocation}");
      Marker marker = Marker(
        markerId: const MarkerId("currentLocation"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(currentLocation.value!.latitude!, currentLocation.value!.longitude!));
      markers.add(marker);
      print("add markers ==========================> current location");
      print("add homeLatitude  ==========================> ${currentLocation.value!.latitude}");
      print("add homeLongtitude ==========================> ${currentLocation.value!.longitude}");
      print("list of marker (from currentlocation) =======> ${markers}");

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 14.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!))));
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        FlutterConfigPlus.get('GG_API_KEY'),
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
  }

  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/pin.png')
  //       .then((icon) {
  //     currentLocationIcon = icon;
  //   });
  // }

  Future<Null> checkPreference() async{
      // get the device firebasetoken
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      print("++++++++++++++++++++++");
      print('token ======> $token');
      // get current user data
      User? currentUser = Get.find<UserController>().currentUser.value;
      currentUser!.fbtoken = token;
      
      var data = {
        "fbtoken" : currentUser.fbtoken,
      };
      var response = await ApiService().putData(data, '/users/${currentUser.id}');

      if (response['success'] == true) {
        print('User Updated Successfully');
        print(response);
      } else {
        print('User Updated Failed');
        print(response['message']);
        Get.snackbar('Error', response['message']);
      }
  }

  void addPassengerMarkers() {
  // List<Marker> markers = [];
  for (int i = 0; i < studentController!.myStudents.length ; i++) {
    print("add markers ==========================> ${studentController?.myStudents[i].fullName}");
    print("add homeLatitude  ==========================> ${studentController?.myStudents[i].homeLatitude}");
    print("add homeLongtitude ==========================> ${studentController?.myStudents[i].homeLongitude}");
    Marker marker = Marker(
      markerId: MarkerId("${studentController!.myStudents[i].fullName}"),
      position: LatLng(studentController!.myStudents[i].homeLatitude!, studentController!.myStudents[i].homeLongitude!),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );
    markers.add(marker);
  }
  print("list of marker (from addPassenger) =======> ${markers}");
}

// at destination
void deleteMarker() {
  if (markers.isNotEmpty) {
    markers.removeAt(0); // Remove the first marker from the list
  }
}


  @override
  void onInit() {
    studentController = Get.find<StudentController>();
    getCurrentLocation();
    // setCustomMarkerIcon();
    getPolyPoints();
    super.onInit();
  }

  @override
  void onReady() {
    studentController = Get.find<StudentController>();
    addPassengerMarkers();
    getCurrentLocation();
    super.onReady();
  }

  @override
  void onClose() {
    getCurrentLocation();
    super.onClose();
  }
}