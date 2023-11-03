import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:school_bus/app/services/api_service.dart';
import 'package:school_bus/app/services/auth_service.dart';
import 'package:school_bus/controllers/report_controller.dart';
import 'package:school_bus/controllers/student_controller.dart';
import 'package:school_bus/controllers/user_controller.dart';
import 'package:school_bus/models/report_model.dart';
// import 'package:school_bus/models/student_model.dart';
import 'package:school_bus/models/user_model.dart';

class MapController extends GetxController {
  final Completer<GoogleMapController> controller = Completer();
  final userController = Get.find<UserController>();
  final reportController = Get.find<ReportController>();
  // final studentController = Get.find<StudentController>();
  final authService = AuthService();
  StudentController? studentController;

  LatLng sourceLocation = LatLng(13.8476, 100.57);
  LatLng destination = LatLng(13.8202, 100.564);

  List<Marker> markers = [];
  List<Step> steps = [];

  List<LatLng> polylineCoordinates = [];

  late Rx<LocationData?> currentLocation =
      Rx<LocationData?>(LocationData.fromMap({
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
          position: LatLng(currentLocation.value!.latitude!,
              currentLocation.value!.longitude!));
      markers.add(marker);
      print("add markers ==========================> current location");
      print(
          "add homeLatitude  ==========================> ${currentLocation.value!.latitude}");
      print(
          "add homeLongtitude ==========================> ${currentLocation.value!.longitude}");
      print("list of marker (from currentlocation) =======> ${markers}");

      // if (polylineCoordinates.isEmpty) {
      //     print("polylineCoordinatespolyline is empty");
      //     getPolyPoints();
      // } else {
      //     print("polyline is not empty");
      // }

      getPolyPoints();

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 14.5,
              target: LatLng(newLoc.latitude!, newLoc.longitude!))));
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    print(
        "get Polypoints==============================================================");
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        FlutterConfigPlus.get('GG_API_KEY'),
        PointLatLng(currentLocation.value!.latitude!,
            currentLocation.value!.longitude!),
        PointLatLng(
            markers[0].position.latitude, markers[0].position.longitude));
    polylineCoordinates.clear();
    if (result.points.isNotEmpty) {
      print("point is NOT EMPTY and clear polyline");
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      print("${polylineCoordinates}");
    } else {
      print("point is EMPTY");
      print("add ${polylineCoordinates}");
    }
  }

  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/pin.png')
  //       .then((icon) {
  //     currentLocationIcon = icon;
  //   });
  // }

  Future<Null> checkPreference() async {
    // get the device firebasetoken
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    print("++++++++++++++++++++++");
    print('token ======> $token');
    // get current user data
    User? currentUser = Get.find<UserController>().currentUser.value;
    currentUser!.fbtoken = token;

    var data = {
      "fbtoken": currentUser.fbtoken,
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
    for (int i = 0; i < studentController!.myStudents.length; i++) {
      print(
          "add markers ==========================> ${studentController?.myStudents[i].fullName}");
      print(
          "add homeLatitude  ==========================> ${studentController?.myStudents[i].homeLatitude}");
      print(
          "add homeLongtitude ==========================> ${studentController?.myStudents[i].homeLongitude}");
      Marker marker = Marker(
        markerId: MarkerId("${studentController!.myStudents[i].id}"),
        position: LatLng(studentController!.myStudents[i].homeLatitude!,
            studentController!.myStudents[i].homeLongitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      );
      markers.add(marker);
      sendNotification(
          studentController!.myStudents[i].id.toString(),
          "Schoolbus Notification",
          "Student: ${studentController!.myStudents[i].fullName} is on the way.");
    }
    print("list of marker (from addPassenger) =======> ${markers}");
  }

// at destination
  void deleteMarker() {
    if (markers.isNotEmpty) {
      Marker marker = markers[0];
      //find student name
      String studentname = "";
      for (var student in studentController!.myStudents) {
        if (student.id.toString() == marker.markerId.value) {
          studentname = student.fullName;
          DateTime now = DateTime.now();
          student.endTime = "${now.hour}:${now.minute}";
        }
      }
      sendNotification(marker.markerId.value, "Schoolbus Notification",
          "Student: $studentname arrived at home");

      markers.removeAt(0); // Remove the first marker from the list
      print("Current marker ============================> ${markers}");
      print("marker length ============================> ${markers.length}");
    }
  }

  void sendNotification(String student_id, String title, String body) async {
    print("SENDING NOTIFICATION+++++++++++++++++++++++++++++++++++++++");
    var data = {
      "student_id": student_id,
      "title": title,
      "body": body,
    };

    final response = await ApiService()
        .postData(data, '/sendNotification/{student_id}/{title}/{body}');
    if (response['success'] == true) {
      print(response);
      // Get.snackbar('Successfully send notification', response['message']);
    } else {
      print("respones__________________________________________________");
      print(response);
      // Get.snackbar('Error (sending notification)', response['message']);
    }
  }

  handleDriverHome() {
    print("========================================");
    DateTime now = DateTime.now();
    reportController.report.value!.endTime = "${now.hour}:${now.minute}";
    print(reportController.report.value!.toJson());
    print("========================================");
    // Send report to server
    final response = ApiService().postData(
        reportController.report.value!.toJson(), '/reports/create-report');
    Get.offAllNamed('/driver-end');
  }

  @override
  void onInit() async {
    studentController = Get.find<StudentController>();
    final userId = await authService.getId();
    await userController.fetchRoute(userId);
    // setCustomMarkerIcon();
    super.onInit();
  }

  @override
  void onReady() async {
    authService.saveState("map");
    studentController = Get.find<StudentController>();
    addPassengerMarkers();
    getCurrentLocation();
    // getPolyPoints();
    super.onReady();
    DateTime now = DateTime.now();

    var report = Report(
      driverId: userController.currentUser.value!.id,
      date: "${now.year}/${now.month}/${now.day}",
      startTime: "${now.hour}:${now.minute}",
      students: studentController!.myStudents,
    );
    reportController.report.value = report;
    print("========================================");
    print(reportController.report.value!.toJson());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
