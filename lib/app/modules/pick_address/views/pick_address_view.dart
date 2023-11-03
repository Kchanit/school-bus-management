import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../controllers/pick_address_controller.dart';

class PickAddressView extends GetView<PickAddressController> {
  const PickAddressView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 10,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: GoogleMap(
            initialCameraPosition:
                controller.cameraPosition!, //initialize camera position for map
            mapType: MapType.normal,
            onCameraIdle: () {
              //this function will trigger when user stop dragging on map
              //every time user drag and stop it will display address
              controller.getAddress(controller.draggedLatlng);
            },
            onCameraMove: (cameraPosition) {
              //this function will trigger when user keep dragging on map
              //every time user drag this will get value of latlng
              controller.draggedLatlng = cameraPosition.target;
            },
            onMapCreated: (GoogleMapController ggController) {
              //this function will trigger when map is fully loaded
              if (!controller.googleMapController.isCompleted) {
                //set controller to google map when it is fully loaded
                controller.googleMapController.complete(ggController);
              }
            },
          ),
        ),
        // Custom pin
        Center(
          child: SizedBox(
            width: 150,
            child: Lottie.asset("assets/pin.json"),
          ),
        ),
        // Show Dragged Address
        Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Center(
            child: Obx(() {
              return Text(
                controller.draggedAddress.value,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              );
            }),
          ),
        ),
        // Search Box
        Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: Container(
            height: 100,
            child: Row(
              children: [
                Expanded(child: locationSearchBox()),
              ],
            ),
          ),
        ),
        // Save Button
        Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                child: const Text('Save'),
                onPressed: () => controller.saveData(),
              ),
            )),
      ]),
    );
  }
}

Widget locationSearchBox() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Enter Your Location',
        suffixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.only(
          left: 20,
          bottom: 5,
          right: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
