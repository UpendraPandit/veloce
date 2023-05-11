// import 'package:flutter/material.dart';
// class List extends StatefulWidget {
//   static var id ='List';
//   const List({Key? key}) : super(key: key);
//
//   @override
//   _ListState createState() => _ListState();
// }
//
// class _ListState extends State<List> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//
//         width:MediaQuery.of(context).size.width*1 ,
//         height:MediaQuery.of(context).size.height*1 ,
//       child: ListWheelScrollView(
//         itemExtent:550,
//         physics: FixedExtentScrollPhysics(),
//         children: [
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.5),
//                 color: Colors.blue,
//               ),
//               width:350,
//               height:1250,
//
//             child: Card(
//                 elevation: 10,
//                 child: Image.network('https://lh3.googleusercontent.com/83Wk0DJinnSgcxehDjr_BEyvLdORXVCkDUiy9eWRCDp0Tnldvb0mLCzCFWwm1SKUcW4VQpIjFVuBbMUo3L5Oi2c3XeiFGcR8CdM_S2D9oXc9AkcSZrXFPRgGWQE6sBlQMJ-bec03IKmKRXrjBgiEs0GNQ9geEWg9JiUnMztwNT8sCKK9mUuA1lcPkWQDFAqrI52iex8QcM-d1oM5twgBtQZI_BcnYqiMSfpM-IOI_iO5i21fxW3tCpoy2QJN_s9IeT28gk8kzxXjw8FE7lZZrwa4rtl6IXk1-H-j5diJyJXX_V4cZT1vX_DVwGl3dh9mu923OA0cRwndHBcRrOvkQvfFWUuXSjH-brIIIFKgJkruRAWd56MzV2kF5_XCrzS5MPl09JBkT84ByWeKG_dwqP3xtf1jfzlZgUIN2pRQReRH-v4IOIjsbyMR1ZzA7Tqqv5K8Q43T4CadILJCcsiQxu0u0SnLAR3yDJ_-qRh7gGjKyAXzC4nt7pnKlfRlsQyYJjb5DHwR3ofGhEKEqJloDy4muHiQNtcCRIKeCeRMhgOuiZ0ECbIzSQluAft8IiNHs_B4ZG_B-XLMeTlqJrj4Coakuhw4kKku5WkHxH4ygjYMARbXdEAaPzrsIUUeHPdXLwxNuOrP8kvLgwKNIUZqQ75z0xBEr7u_fAoqSHXg4jtiAON6gms561yTefvxPnM7EPWwrFEGEDTwQns93bh1ZeqhV_teH3Dhu56zCEqKhfB5Pl_7agWZMyP2lGegRAFJ9gDewIiVIwIr_-OUaQiVGX67z-gsIRiB_N62yPN7xx5FAUI548QFtzLkCQOWE_4fFq0brEl7tf5udnTZQlAE90TG4dhJX0ejHssYPnbCmiWKoqNQlu7IIoJlOYfxHV6MX4wPoAGfL67PIdA7qd1D_zA5NxG_d9EgWC_bsSpAm23G5AoEeS3noJQ_u4WmaKsZ7BDPukCvXuq_UqjJsBE7yLm4LvN6gjObOVR6HZXNN5ykXqAlFfyCax6BrQlyozELZNLJ88B4wGo9NyS2m9rsLZrBW5E=w700-h933-s-no?authuser=0',fit: BoxFit.fill,)),
//             ),
//           ),    Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.5),
//                 color: Colors.blue,
//               ),
//               width:350,
//               height:1250,
//
//             child: Card(
//                 elevation: 10,
//                 child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/GT9eYbmnt6OB5hpuvnsKSir6S9r6tvKT4-dnqgmoWqjLWa4QjuFV4nxTB2JkUYI5XKs34cMcpXch5ZjYn4ibjn8nVXhqIneebTkODm1qpg6oKb1O9LB20t34jXmHVXht6wGuQJEdCZ0IOuKorZyWer96zKAaUZEJBML9ELu30x0OYTWeggvnd82_cZ4frGmYk5z4x99piboyV7azIMsuAioO5h7Kpz7SIR8g2vyyIzqxHttYmw5TpO1yMfN98WewxuTuiiOB4meZV9M7bho_3QjKwkCQz36E7bKyEneUTq63Bh6bgkpTcZUW8UQWUry5UClLqho79URwcymvxekOUTLAgEoM4yt1aPKU_eyU9hodY37yZNJc_VG4tWhgG3lY0hEZkYb6R1McTSggSc6wSgUXZqbZuyZ_8MYLeEjl2k1wGjGU09FpLR7DtQqV2CDEFQ8vuYOS4Jm0gM--PtV8cZMBfOFRCzm_ZE6SsMdZhxBJOIVqDaxf7D_rADYdx9bjyorF8PfTmygAX6wyEJ0V38PnyKDKI-y85qGIwfn53mOqte_twTG0JdA4Vd5XxECljBagtSqZZDC8TCYVUAYb6wv12Y0sPHjOruKbu8rRoYYYH2Hl7BMQ52H__rsNlauCx3j778ywdGyZ_A3KGJRFzLRGOks2-kG4pMDPBjoMHItjkVhMn8-J9lbWsmiCxAUB-x_3_j37vS5RqQBh3g8sPYa_SAo6MtAp43eFf4HrfLbQK5JcKcR-eCwJfgZRXKGVsW65pWOyzygO5FxnYoqffYDq2Qjy_DOcU0oOTkMZuCpW61h_J-PfpAtGZ6lZmhLqgQA_xMbn0b-CHrOsmtfqxcPd2sFaaQaBPVNSdr_AcGVX_t5z7C3TC98gWpiUki67H-tw9YWTfipM14wXWpWF_snvAFZ3NpiWIhOOlF0CcTp2iZGCdMSjNUomKM9ALOsC2VdwqFBIKgJjvkT-4UjgANG29EY6YR5qH0VwA_XuBLiBc7tNOZ41F7S0VsHqbIvKWdl33C3A-wJWHkbtspr3SLaYmqo=w700-h933-s-no?authuser=0')),
//             ),
//           ),    Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.5),
//                 color: Colors.blue,
//               ),
//               width:350,
//               height:1250,
//
//             child: Card(
//                 elevation: 10,
//                 child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/xU7jXjSKRxHUeeCJihJlfp8l3STqDANvqmDgSEfVktY3eIktYK73p1GKieYPMFwYyc2QZkoBN4rM2qRxEm2rohqAruYlEMGHmdTV9MDx7c8e4p3RLLOramBad6Qy0XtUh76mlYlWm8Mytv8SV4mYB1FrkvCQnNR0mREmS5InNICbSRmMAeTdiFoyI4WA1RFWaBMHpJv91n1l5EpRKDgyXBhBxpReApEGgrR2J0W_9184lWImnZq0QST5pUlV_m6g-qe6sG-09cI-QZUjPfJw9k_Kf_UKNe60xfFEXUyHHbXxOHqln7WubOrOzIkHAflg9JGKl6FOXzA1YkSJOWVZD6sWPkCttcI3CZXDhBvTBt7UmU0auwuwq4KjVK8oJ1jD577_0NJDOE3Wg-Q2FYGC_bKkPPMBbzcKR0MDFeFylqB5iAUGnrBB4xsWze_iLgibmGwp7kK9bm91VrksrYzpI8KBVgoCU96EaLWV1XGnf3g25Y5RTiyM6S9Xit1IB8unkTzQkpisD0vv2aapj7LX1U7cQDE6IQ_0rNcgMF3R5Yh4hJnezm7JIYf858v8sI0j5-aXYxC2Stw4qSm5Y4LJy6dNa4sQ5uFrnuOjt2kz9xc32Lg0CD2cyOQ0j_G5vNtjv20S3NZtTBtLBSlmtj8DIKJjF49LefTLdUkyiSJfEhqmr7i0snyvszcjSFVqfuPorDctN-u3gCB2sDQ1IpsPGpjn5Zn85aVaGwHYyiWKPIWSxmgTpd6dErA3131qOXnpx0cCZ4hRDCx7Cwrh9WE_XG0yKcsqZzZnpvE7A2RAirVplTxuNrmj-8TNBmt3Ixt65NYBkr1qwVw87tuHi0z7hbfNve8Qgq6hrhxAwCcGEHGp6ga8GK6c5z7IvUdkO4ugyBEQ322KLTysBpmGCn8IXUGaq7o6M9YpcOG3BmwSIokcVdYl_gXrEmbzTKAkn00s7iZls5tvoZGpTnSHM8SVgXPN8zLBRMhbKE3TchBJqPXgLVDn0RrKTd7HeOH1dMm1tuay7uJBShe4adqyvDw6iXKIZ4E=w700-h933-s-no?authuser=0')),
//             ),
//           ),    Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.5),
//                 color: Colors.blue,
//               ),
//               width:350,
//               height:1250,
//
//             child: Card(
//                 elevation: 10,
//                 child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/1vLsvQS_96K8YFfxB3q1wTNMvNRfC1QBYIwx7NqYzqh6oPQigiEAZFrjgBxSVZj7FrI5daylQkng1OvjRTI3UOPBxeBOrcQqSqMl7Vwvy6JR1GZAgS40lSz-ojX11Wdh_TtI00DrkocQZLT4vveA3hLZ5lBXJPbtNqbBTyLhe4NrPOptQJW86j4fhq8E8JMMqQo9EACM5ylv5o01u3TvV22SkMJ43xkEFBXc8APZUSgTrNPibc-0StlVuOVAnSkrb7L33SHXLiIDmDlJo4IPycB0-a7PM1tRlYn8f38laL-PM583KgB7rSTRggsa3odgbfrtBWU5QnbkTOVt5f9ebEHH8YyNvDJL1r6SZ-1MVhlqtIqGZcp1i5OpWb78gpNRymkYLOotNAfH_h67EhamMvHxzecFRxvEpMaOHxZyK-cHENYHSnZ3FgD5_SBoKsM5uH8S__GXkZ8-wHkazKpVphhNwvEHJlyJ3u51m6MNtK9KlP4idHgHr_7twX6q2PiVscxUAt5FrWzqISTtOLvSXY4DK57-uPqQfC03Cg7KnJ5oyQ3Fxg6paAfpedPOV1btZjyxQilZiRhJk5RqPLI79rAOa61HdQ8KGVdvsZg_dOFBmyngiD64fTDe0wfbDcGq0ebMoi34ouMCmakScuGHC2p4zXQsEZMhKqA7928wWSWgOmWK-TcWW5BUd6ZSanFUxXuVFc0aKoKMbkRgilgi7hhD6b6zJDXjRaf6SBU_YcWx_e2rTIc4g52SjDRBSnpVddkgMZ2aLIcSxhj1s75ubPzbI3Fqn3Um5YdAb81X_FBxn2KNT-LxqjwCatmQDa8Qgmo7TkGQcm9N_NJ0F5vinR7eEL5dSbJk11gO-z5iO6YJmo9l8ZwiIhuiT_o_bK69IVoUfPBHlVcgdOfUgrnZrwGrIXIGzu4HonTReFr1LOahZ3swpcQi7kqM5wynZvMvLlW4XbaYJBiuahdUVADxMfwZbltwqtlZSVmxfmD-bsCH1wmMkW3TLs8TIaYwgOyCHmSnKoUYjr4zDgwySN9KLh9yCdg=w700-h933-s-no?authuser=0')),
//             ),
//           ),    Center(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.5),
//                 color: Colors.blue,
//               ),
//               width:350,
//               height:1250,
//
//             child: Card(
//                 elevation: 10,
//                 child: Image.network(fit: BoxFit.fill,'https://lh3.googleusercontent.com/-wryxoqdMuXc6aBzvyrftT43aAuVorX-9T6fvmYOzp35iB0NLii4obNmGchjoBRqyg7_Sm6dGx-Uh7omY9DjGY-GDvM1VB1JAeWTMniX72pmyM4oomFqHBIklSqiNx55fr8kgwqTzu3WvBBkO6RgzFJ7JrdY2IzY2Th8Ns3nHvQRcNh5Bh8nzl8l0crFsmVx0utE5DbaoUwByqBgSRzkqXgJczj3GM5b2HlZuygQK6mV57cIwa0da-1JFym9FdLegcX6G2mb5rfUlCa9_MSnLk0M8oPI4Bo7yaCauDAp1TlsxYh-9VZfXqb6JQmGucAkU29LG92Ws4EIr8FhMsWyqYyXOnh8lLpB5UZFaLLhY4UaWM1DKUVLhMBGHPdBJqhrwdT2hOnnBgdpVLa4Hy2SAB1eRty_6n3hpM97b4mYD_hRRGp2iOr-0DgSAMXpuKozrsvN8fZpIvJ-lQsftjD5-ZapwN3sVk5XzxcHnDThK-6S7JRTTJ-nRAetmlFWEaYSRKaGa_WHwmk4bTiAAyzCpekq2hpbRDkrKN7yE2Rf8t-2u-cdU1MyS9ut0bAn01HzZZxbii3XigG8gk4exfDmcwCcbs-D3F9SH9YsPf3cLlNKzWazaYYs9SsKyRm4nsFOyFHExcp6basNn8RgCXQELao_8qxSqUgnxszvhu50lgxDDGjxaL6ARs4PlQBPi-7QDp6yz9t3A7k060t5hmwdshTWNE7hNOQaRSSVbkuvkZ5JAQiPd8xzna0JtslFn9Odg9VRZiOqoZZAMnHcEUiOe6Xu1ZLVNkA-xcVV99qzX5bafBisi28FOWidWaBfbqTkJ5DMGOlnYlM5sBvwsYc5IyL2XC1mfuq3xfQY-4yL4ZmnqOVVZ6-4h4F_e77ktcbz_pvk7xXMbCVczfW5JyeQBn4x24Jzg6en0ihW9y4UQNf4wE3RHFCFqUbxvUYrGDYwG56uefw1SKf20oXh4qSjU-Rt1369asAfchYGNwir4AEOnqhAFO67OQuzxHORrB5Gez1ao4mZWbetsOFmkktHw-PDuEM=w700-h933-s-no?authuser=0')),
//             ),
//           ),        ],
//       ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:veloce/sizeConfig.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/Consts/constants.dart';
import 'package:google_maps_webservice/places.dart' as gmws;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
var wayPointVal = const LatLng(0.0, 0.0);
class Pilot extends StatefulWidget {
  static var id = 'PilotScreen';

  const Pilot({Key? key}) : super(key: key);

  @override
  _PilotState createState() => _PilotState();
}

class _PilotState extends State<Pilot> {
  Timer? timer;

  @override
  void dispose() {
    print("object");

    // TODO: implement dispose
    googleMapController!.dispose();

    print('called');
    super.dispose();
  }


  final Completer<GoogleMapController> _mapController = Completer();
  late LatLng src =
  LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

  static LatLng des = const LatLng(-30.2968691, -30.2968691);
  LatLng markerDestination = const LatLng(-30.2968691, -30.2968691);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  var temp = [1.0, 1.0];
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor srcIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;
  String searchLocation = "SearchLocation";
  bool itcheck = false;
  GoogleMapController? googleMapController;
  var destWidgetCheck = false;
  var isDestinationSelected = false;
  var isStarted = true;
  var isSentOnce = false;

  var isTripNotStarted = true;
  double distance = 0;
  double sum = 0;
  var isWayPointSet = false;
  var wayPointMarkerLocked = true;
  var pCoordinates;
  var stream;
  var showRequest = false;
  var updatePolyLines = <List<double>>[];
  List<List<double>> coordinates = [];

  void getPilotLocation() async {
    Location location = Location();
    if (!mounted) {
      return;
    }
    location.getLocation().then((location) {
      if (!mounted) {
        return;
      }

      setState(() {
        currentLocation = location;
        print(currentLocation);
      });
    });
    googleMapController = await _mapController.future;
    location.onLocationChanged.listen((newLoc) {
      if (!mounted) {
        return;
      }
      setState(() {
        HelperVariables.pilotcurrentLocation = newLoc;
        currentLocation = newLoc;
        //  polylineCoordinates.clear();
        if (polylineCoordinates.isNotEmpty) {
          for (LatLng ltln in polylineCoordinates) {
            if (LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!) ==
                ltln) {
              setState(() {
                itcheck = true;
              });
            }
          }
          if (itcheck == true) {
            for (int i = 0;
            polylineCoordinates[i] !=
                LatLng(currentLocation!.latitude!,
                    currentLocation!.longitude!);
            i++) {
              polylineCoordinates.removeAt(i);
            }
            setState(() {
              itcheck = false;
            });
          } else {
            setState(() {
              // polylineCoordinates.clear();
              // getPolyPoints(des.latitude, des.longitude);
            });
          }
        }

        //     getPolyPoints(des.latitude, des.longitude);
        // googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        //     CameraPosition(bearing: 45, zoom: 17.5, tilt: 1.2, target: src)));
      });
    });
  }


  void getPolyPoints(double dlat, double dlong) async {
    if (!mounted) return;
    print("tryin to enter the poly points sections");
    polylineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        map_api_key,
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(dlat, dlong),
        wayPoints: [
          PolylineWayPoint(
              location: isWayPointSet
                  ? "${wayPointVal.latitude},${wayPointVal.longitude}"
                  : "",
              stopOver: false),
        ],
        travelMode: TravelMode.driving,
        optimizeWaypoints: true);

    List<mp.LatLng> poly = [];
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        // poly.add(mp.LatLng(point.latitude, point.longitude));
      }
      pCoordinates = polylineCoordinates;
      setState(() {
        sum = 0;
        for (int i = 0; i < polylineCoordinates.length - 1; i++) {
          sum += calculateDistance(
              polylineCoordinates[i].latitude,
              polylineCoordinates[i].longitude,
              polylineCoordinates[i + 1].latitude,
              polylineCoordinates[i + 1].longitude);
        }
        distance = double.parse(sum.toStringAsFixed(2));

        // var val=getDistance();
        // print('The distance is $val');
      });
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  String getGeoHashedValue(LocationData? loc) {
    var geohasher = GeoHasher();
    var val = geohasher.encode(loc!.longitude!, loc.latitude!, precision: 6);
    return val;
  }

  Future generatePolyLinesForTheUpdate() async {
    updatePolyLines.clear();
    PolylinePoints polyline = PolylinePoints();
    PolylineResult result = await polyline.getRouteBetweenCoordinates(
        'AIzaSyBSrF5pLo5KLbOfEcifs1TuoTAm20qCM0M',
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(des.latitude, des.longitude),
        wayPoints: [
          PolylineWayPoint(
            location: isWayPointSet
                ? "${wayPointVal.latitude},${wayPointVal.longitude}"
                : "",
            stopOver: false,
          ),
        ],
        optimizeWaypoints: true,
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        updatePolyLines.add([point.longitude, point.latitude]);
      }
    }
  }


  @override
  void initState() {
    try {
      markersAdd();
    } catch (e) {
      print(e);
    }
    // TODO: implement initState
    super.initState();
  }

  // @override
  // // void deactivate() {
  // //   print('Entered deactivate function');
  // //   deleteUser(int.parse(HelperVariables.Phone));
  // //   // TODO: implement deactivate
  // //   super.deactivate();
  // // }
  void markersAdd() async {
    getPilotLocation();
  }

  Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
          child: Scaffold(
            body: currentLocation == null
                ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3.5,
                ))
                : SingleChildScrollView(
              child: SizedBox(
                height: SizeConfig.safeBlockVertical * 100,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: Stack(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 100,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      child: GoogleMap(
                        onCameraMove: (cameraPosition) {
                          print(cameraPosition.toMap().toString());
                          print(cameraPosition.bearing);
                          markerDestination = LatLng(
                              cameraPosition.target.latitude,
                              cameraPosition.target.longitude);
                        },
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        onTap: wayPointMarkerLocked
                            ? (LatLng val) {}
                            : (LatLng val) {
                          setState(() {
                            if (destWidgetCheck) {
                              wayPointVal = val;
                              isWayPointSet = true;
                              polylineCoordinates.clear();
                              getPolyPoints(
                                  des.latitude, des.longitude);
                              print(wayPointVal);
                            }
                          });
                        },
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        buildingsEnabled: false,
                        tiltGesturesEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 17.5,
                        ),
                        polylines: {
                          Polyline(
                              polylineId: const PolylineId("route"),
                              points: polylineCoordinates,
                              color: Colors.black,
                              width: 5,
                              geodesic: false),
                        },
                        markers: {
                          // Marker(
                          //   markerId: const MarkerId('current Location'),
                          //   position: src,
                          //   consumeTapEvents: true,
                          //   // position: LatLng(currentLocation!.latitude!,
                          //   //     currentLocation!.longitude!),
                          //   icon: srcIcon,
                          // ),
                          Marker(
                            markerId: const MarkerId('wayPoint'),
                            position: wayPointVal,
                            visible: isWayPointSet,
                            icon: BitmapDescriptor.defaultMarkerWithHue(200),
                          ),
                          // Marker(
                          //   markerId: const MarkerId('destination'),
                          //   position: des,
                          //   icon: destinationIcon,
                          // ),
                        },
                        onMapCreated: (mapController) {
                          setState(() {
                            _mapController.complete(mapController);
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: isStarted,
                      child: Positioned(
                        bottom: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.safeBlockHorizontal * 15,
                        child: InkWell(
                            onTap: () async {
                              setState(() {
                                isWayPointSet = false;
                              });
                              var place = await PlacesAutocomplete.show(
                                  context: context,
                                  apiKey: map_api_key,
                                  overlayBorderRadius:
                                  BorderRadius.circular(25),
                                  logo: Container(
                                    width:
                                    SizeConfig.safeBlockHorizontal * 100,
                                    height: SizeConfig.safeBlockVertical * 7,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(25)),
                                  ),
                                  mode: Mode.overlay,
                                  types: [],
                                  strictbounds: false,
                                  radius: 50,
                                  components: [
                                    gmws.Component(
                                      gmws.Component.country,
                                      'in',
                                    ),
                                  ],
                                  onError: (err) {
                                    print(err);
                                  });
                              if (place != null) {
                                setState(() {
                                  searchLocation =
                                      place.description.toString();
                                });
                                final plist = gmws.GoogleMapsPlaces(
                                  apiKey: 'AIzaSyBSrF5pLo5KLbOfEcifs1TuoTAm20qCM0M',
                                  apiHeaders: await const GoogleApiHeaders()
                                      .getHeaders(),
                                );
                                String placeId = place.placeId ?? "0";
                                print(placeId);

                                final detail =
                                await plist.getDetailsByPlaceId(placeId);
                                final geometry = detail.result.geometry!;
                                final lat = geometry.location.lat;
                                final long = geometry.location.lng;
                                var newLatLng = LatLng(lat, long);
                                setState(() {
                                  des = LatLng(lat, long);
                                  isDestinationSelected = true;
                                });

                                googleMapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: newLatLng, zoom: 17.5)));

                                polylineCoordinates.clear();
                                getPolyPoints(des.latitude, des.longitude);
                                // var polyCheck = true;
                                destWidgetCheck = true;
                              }
                            },
                            child: destWidgetCheck
                                ? Center(
                              child: SizedBox(
                                  height:
                                  SizeConfig.safeBlockVertical * 7,
                                  width:
                                  SizeConfig.safeBlockHorizontal *
                                      14,
                                  child: Card(
                                    color: Colors.black.withOpacity(1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25)),
                                    elevation: 5,
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit_location_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            )
                                : SizedBox(
                              height: SizeConfig.safeBlockVertical * 6,
                              width:
                              SizeConfig.safeBlockHorizontal * 65,
                              child: Card(
                                  color: Colors.black.withOpacity(1),
                                  elevation: 5,
                                  child: const Center(
                                    child: Text(
                                      'Enter your destination',
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
