// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../controllers/googlemap_controller.dart';

// class GooglemapView extends GetView<GooglemapController> {
//   //  const GooglemapView({Key? key}) : super(key: key);
//   GooglemapView({Key? key}) : super(key: key);

//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(13.816510, 100.561789),
//     zoom: 11.5,
//   );

//   late GoogleMapController _googleMapController;
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('GooglemapView'),
//         centerTitle: true,
//       ),
//       body: GoogleMap(
//         myLocationEnabled: false,
//         zoomControlsEnabled: false,
//         initialCameraPosition: _initialCameraPosition,
//       ),
//       floatingActionButton: FloatingActionButton(
//         // backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.black,
//         onPressed: () => _googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(_initialCameraPosition),
//         ),
//         child: const Icon(Icons.center_focus_strong),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/googlemap_controller.dart';

class GooglemapView extends StatelessWidget {
  final GooglemapController controller = Get.put(GooglemapController());

  GooglemapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GooglemapView'),
        centerTitle: true,
      ),
      body: GoogleMap(
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: controller.initialCameraPosition,
          onMapCreated: controller.onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        onPressed: () {
          controller.moveCameraToInitialPosition();
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
