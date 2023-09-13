import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestController extends GetxController {
  // var initialCameraPosition = const CameraPosition(
  //   target: LatLng(13.8, 100.5),
  //   zoom: 17.5,
  // );
  // late GoogleMapController googleMapController;

  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition? cameraPosition;
  late LatLng defaultLatLng;
  Position? currentPosition;

  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyD_Fw72DnY6QPUrT6vowTa55pssGiDFEoc");
  Marker? origin;
  Marker? destination;
  final Set<Polyline> polylines = {};
  // List<LatLng>? routeCoords;
  @override
  void onInit() async {
    super.onInit();
    await _gotoUserCurrentPosition();
    cameraPosition = CameraPosition(target: defaultLatLng, zoom: 17.5);
  }

  void initialize() async {
    print("initialize");
    await _gotoUserCurrentPosition();

    origin = Marker(
      markerId: MarkerId("origin"),
      position: defaultLatLng,
      infoWindow: InfoWindow(title: "Origin"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    destination = Marker(
      markerId: MarkerId("destination"),
      position: LatLng(13.842564599,
          100.5699795484543), // Replace with your destination coordinates
      infoWindow: InfoWindow(title: "Destination"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    await drawRoute();
  }

  Future _gotoUserCurrentPosition() async {
    currentPosition = await _determineUserCurrentPosition();
    defaultLatLng =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    // cameraPosition = CameraPosition(target: defaultLatLng, zoom: 17.5);
    // _gotoSpecificPosition(
    //     LatLng(currentPosition!.latitude, currentPosition!.longitude));
  }

  Future<void> drawRoute() async {
    if (origin == null || destination == null) {
      return;
    }

    final route = await googleMapPolyline.getCoordinatesWithLocation(
      origin: LatLng(origin!.position.latitude, origin!.position.longitude),
      destination: LatLng(
          destination!.position.latitude, destination!.position.longitude),
      mode: RouteMode.driving,
    );

    final polyline = Polyline(
      polylineId: PolylineId("route"),
      points: route!,
      width: 4,
      color: Colors.blue,
    );

    polylines.clear();
    polylines.add(polyline);
    update();
  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
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
