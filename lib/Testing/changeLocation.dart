// // import 'dart:async';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';
// // import 'package:veloce/Consts/constants.dart';
// // import 'dart:math';
// //
// // class ChangeLocation extends ChangeNotifier {
// //   bool itcheck = false;
// //   List<LatLng> polylineCoordinates = [];
// //   static LatLng des = const LatLng(-30.2968691, -30.2968691);
// //   LocationData? currentLocation;
// //   final Completer<GoogleMapController> _mapController = Completer();
// //
// //
// //
// //
// //   void getLocation() async {
// //   print('entrerd');
// //     Location location = Location();
// //     GoogleMapController? googleMapController;
// //     location.getLocation().then((location) {
// //       currentLocation = location;
// //     });
// //     googleMapController = await _mapController.future;
// //     location.onLocationChanged.listen((newLoc) {
// //       currentLocation = newLoc;
// //       print(currentLocation);
// //       if (polylineCoordinates.isNotEmpty) {
// //         for (LatLng ltln in polylineCoordinates) {
// //           if (LatLng(currentLocation!.latitude!, currentLocation!.longitude!) ==
// //               ltln) {
// //             // setState(() {
// //             //   print('entered');
// //             //   itcheck = true;
// //             // });
// //           }
// //         }
// //         if (itcheck == true) {
// //           for (int i = 0;
// //               polylineCoordinates[i] !=LatLng(currentLocation!.latitude!, currentLocation!.longitude!);i++) {
// //             polylineCoordinates.removeAt(i);
// //           }
// //
// //         } else {
// //           polylineCoordinates.clear();
// //           getPolyPoints(currentLocation,des.latitude, des.longitude);
// //         }
// //       }
// //     });
// //   }
// // var distance;
// //   var sum;
// //   double calculateDistance(lat1, lon1, lat2, lon2) {
// //     var p = 0.017453292519943295;
// //     var a = 0.5 -
// //         cos((lat2 - lat1) * p) / 2 +
// //         cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
// //     return 12742 * asin(sqrt(a));
// //   }
// //   void getPolyPoints(LocationData? loc, double dlat, double dlong) async {
// //     PolylinePoints polylinePoints = PolylinePoints();
// //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //       map_api_key,
// //       PointLatLng(loc!.latitude!, loc.longitude!),
// //       PointLatLng(dlat, dlong),
// //       travelMode: TravelMode.driving,
// //     );
// //
// //     if (result.points.isNotEmpty) {
// //       for (var point in result.points) {
// //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //       }
// //
// //         sum = 0;
// //         for (int i = 0; i < polylineCoordinates.length - 1; i++) {
// //           sum += calculateDistance(
// //               polylineCoordinates[i].latitude,
// //               polylineCoordinates[i].longitude,
// //               polylineCoordinates[i + 1].latitude,
// //               polylineCoordinates[i + 1].longitude);
// //         }
// //         distance = double.parse(sum.toStringAsFixed(2));
// //         print('The distance is $distance');
// //         // var val=getDistance();
// //         // print('The distance is $val');
// //
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import '../Helper/HelperVariables.dart';
//
//
// void main() => runApp(MyApp());
// var channel;
// var stream;
// void initailizeWebsocket() async {
//   channel = WebSocketChannel.connect(
//       Uri.parse('ws://139.59.44.53:3005?phone=${HelperVariables.Phone}'));
//
//   // channel.sink.add(HelperVariables.passengercurrentLocation);
//   stream = channel.stream;
//   channel.stream.listen((event) {
//     print('kuch aaya00');
//     print("$event");
//     print(event.runtimeType);
//
//   });
//   print("exitted websocekt method ");
// }
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'StreamProvider Demo';
//     return MaterialApp(
//         title: appTitle,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: StreamProvider<LatLng>(
//          initialData: const LatLng(23.23,14.32),
//         create: (_) => stream,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text(appTitle),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Consumer<LatLng>(
//                     builder: (context, percentDone, child) {
//                       if (1 < 100) {
//                         return Text("Loading... ($percentDone% done)");
//                       }
//                       return const Text("Done loading!");
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
