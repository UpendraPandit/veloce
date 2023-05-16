import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veloce/Screens/first.dart';
import 'package:veloce/Screens/pilotripscreen.dart';
import 'package:veloce/sizeConfig.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
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

var wayPointVal = const LatLng(0.0, 0.0);

Future<String> getAddressFromLatLng(double lat, double lng) async {
  if (lat != null && lng != null) {
    var response = await http.get(
        Uri.parse(
            'https://maps.google.com/maps/api/geocode/json?key=AIzaSyBSrF5pLo5KLbOfEcifs1TuoTAm20qCM0M&language=en&latlng=$lat,$lng'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String _formattedAddress = data["results"][0]["formatted_address"];
      return _formattedAddress;
    } else
      return null.toString();
  } else
    return null.toString();
}

class PilotScreen extends StatefulWidget {
  static var id = 'PilotScreen';

  const PilotScreen({Key? key}) : super(key: key);

  @override
  _PilotScreenState createState() => _PilotScreenState();
}

class _PilotScreenState extends State<PilotScreen> {
  Timer? timer;

  @override
  void dispose() {
    deleteUser(int.parse(HelperVariables.Phone));
    print("object");

    // TODO: implement dispose
    googleMapController!.dispose();

    print('called');
    super.dispose();
  }

  final queue = Queue<int>();
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
  final player = AudioPlayer();
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

  void getTheDetailsOfRiders() async {
    var response = await http
        .get(Uri.parse('http://209.38.239.47/users/user?phone=7452976914'));
    var data = jsonDecode(response.body);
    print(data);
  }

  void playMusic() async {
    // await player.setSource(AssetSource('sound.wav'));
    await player.play(AssetSource('sound.wav'));
  }

  void stopMusic() async {
    // await player.stop();
    await player.release();
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
        map_api_key,
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

  void updatePilotLocation() async {
    await generatePolyLinesForTheUpdate();
    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    print(updatePolyLines);
    final msg = jsonEncode({
      "phone": int.parse(HelperVariables.Phone),
      "long": currentLocation!.longitude!,
      "lat": currentLocation!.latitude!,
      "updatePolyLines": {"coordinates": updatePolyLines, "type": "LineString"},
    });

    var url = Uri.parse('http://139.59.44.53/pilots/updateUser');
    var response = await http.put(url, body: msg, headers: header);
    print("User updated");
    print("${response.body}kuch ni aaya");
    print("Userasdsads updated");
  }

  void initailizeWebsocket() async {
    final channel = WebSocketChannel.connect(
        Uri.parse('ws://139.59.44.53:3001?phone=${HelperVariables.Phone}'));
    channel.sink.add("Hello From flutter");
    setState(() {
      stream = channel.stream;
    });
    print("exitted websocket method ");
  }

  void getUserInfo() async {
    var res = await http.get(Uri.parse(
        'http://209.38.239.47/users/user?phone=${HelperVariables.Phone}'));
    var data = jsonDecode(res.body);
  }

  Future acceptUser(int passengerPhone, int pilotPhone, var abc) async {
    var res = await http.get(Uri.parse(
        'http://209.38.239.190/accepted?pilot=$pilotPhone&passenger=$passengerPhone'));
    print("Is it because of this?!");
    print(res.body);
    if (!mounted) {
      return;
    }
    setState(() {
      HelperVariables.otherPhone = passengerPhone;
      HelperVariables.passengerDest = abc;
    });
  }

  void sendPilotLocation(List<List<double>> param) async {
    print(param);
    var currLocation = getGeoHashedValue(currentLocation);
    var geohasher = GeoHasher();
    var destination =
        geohasher.encode(des.longitude, des.latitude, precision: 6);
    print(currLocation);
    print(destination);
    Uri url;
    if (!isSentOnce) {
      url = Uri.parse('http://139.59.44.53/pilots/pushNewUser');
    } else {
      url = Uri.parse('http://139.59.44.53/pilots/updateUser');
    }

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    print(HelperVariables.Phone);
    print(currentLocation);
    final msg = jsonEncode({
      "name": HelperVariables.Name,
      "phone": int.parse(HelperVariables.Phone),
      "gender": HelperVariables.gender,
      "location": {
        "coordinates": [
          currentLocation!.longitude!,
          currentLocation!.latitude!
        ],
        "type": "Point"
      },
      "polylineLocs": {"coordinates": param, "type": "LineString"},
      "waypoint": wayPointVal,
      "destination": destination,
      "request": 0,
    });

    var response = await http.post(url, body: msg, headers: header);
    print(response.body);
    if (!mounted) return;
    timer = Timer.periodic(
        const Duration(seconds: 4), (Timer t) => updatePilotLocation());
  }

  var Address = "Fetching Address...";

  @override
  void initState() {
    try {
      markersAdd();
    } catch (e) {
      print(e);
    }

    initailizeWebsocket();
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

  void deleteUser(int phone) async {
    print("Deleting the phone");
    var url = Uri.parse('http://139.59.44.53/pilots/deleteUser?phone=$phone');
    var resp = await http.delete(url);
    print('IS this the ${resp.body}');
  }

  void markersAdd() async {
    getPilotLocation();
  }

  Set<Marker> marker = {};

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    print("$lat,$lng");

    if (lat != null && lng != null) {
      print("Enasdasdasdterasded");
      var response = await http.get(
          Uri.parse(
              'https://maps.google.com/maps/api/geocode/json?key=AIzaSyBSrF5pLo5KLbOfEcifs1TuoTAm20qCM0M&language=en&latlng=$lat,$lng'),
          headers: {"Content-Type": "application/json"});
      print('awe');
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else
        return null.toString();
    } else
      return null.toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(FirstScreen.latitude);
    return ChangeNotifierProvider<MyModel>(
        create: (BuildContext context) => GetModel(),
        child: WillPopScope(
          onWillPop: () async {
            deleteUser(int.parse(HelperVariables.Phone));
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
                            child: Consumer<MyModel>(
                                builder: (context, MyModel, child) {
                              return GoogleMap(
                                // onCameraMove: (cameraPosition) async {
                                //   markerDestination = LatLng(
                                //       cameraPosition.target.latitude,
                                //       cameraPosition.target.longitude);
                                //  MyModel.doS(cameraPosition.target.latitude,
                                //       cameraPosition.target.longitude);
                                //  // getPolyPoints(cameraPosition.target.latitude, cameraPosition.target.longitude);
                                //
                                // },
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
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        200),
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
                              );
                            }),
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
                                              SizeConfig.safeBlockHorizontal *
                                                  100,
                                          height:
                                              SizeConfig.safeBlockVertical * 7,
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
                                        apiKey: map_api_key,
                                        apiHeaders:
                                            await const GoogleApiHeaders()
                                                .getHeaders(),
                                      );
                                      String placeId = place.placeId ?? "0";
                                      print(placeId);

                                      final detail = await plist
                                          .getDetailsByPlaceId(placeId);
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
                                                  target: newLatLng,
                                                  zoom: 17.5)));
                                      await _WayPoint();
                                      polylineCoordinates.clear();
                                      getPolyPoints(
                                          des.latitude, des.longitude);
                                      // var polyCheck = true;
                                      destWidgetCheck = true;
                                    }
                                  },
                                  child: destWidgetCheck
                                      ? Center(
                                          child: SizedBox(
                                              height:
                                                  SizeConfig.safeBlockVertical *
                                                      7,
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  14,
                                              child: Card(
                                                color:
                                                    Colors.black.withOpacity(1),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                elevation: 5,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons
                                                        .edit_location_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                        )
                                      : SizedBox(
                                          height:
                                              SizeConfig.safeBlockVertical * 6,
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  65,
                                          child: Card(
                                              color:
                                                  Colors.black.withOpacity(1),
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
                          Visibility(
                            visible: isDestinationSelected && isTripNotStarted,
                            child: Positioned(
                              bottom: SizeConfig.safeBlockVertical * 2,
                              left: SizeConfig.safeBlockHorizontal * 30,
                              child: SizedBox(
                                height: SizeConfig.safeBlockVertical * 6,
                                width: SizeConfig.safeBlockHorizontal * 45,
                                child: Card(
                                    color: Colors.black.withOpacity(1),
                                    elevation: 5,
                                    child: InkWell(
                                      onTap: () {
                                        if (!mounted) {
                                          return;
                                        }
                                        setState(() {
                                          isStarted = false;
                                          wayPointMarkerLocked = true;
                                        });
                                        print(
                                            "Checking whether the problem exists here in pCoordinates or not!");
                                        print(pCoordinates);

                                        coordinates.clear();

                                        for (int i = 0;
                                            i < pCoordinates.length;
                                            i++) {
                                          coordinates.add([
                                            pCoordinates[i].longitude,
                                            pCoordinates[i].latitude
                                          ]);
                                        }
                                        print(
                                            "Checking whether the problem exists here or not!");
                                        print(coordinates);
                                        sendPilotLocation(coordinates);
                                        isTripNotStarted = false;
                                        isSentOnce = true;
                                      },
                                      child: const Material(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Text(
                                            'Start your ride!',
                                            style: TextStyle(
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Positioned(
                            left: SizeConfig.safeBlockHorizontal * 3,
                            right: SizeConfig.safeBlockHorizontal * 3,
                            bottom: SizeConfig.safeBlockVertical * 7.5,
                            child: StreamBuilder(
                              stream: stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                print("entered");
                                var response;
                                print(response);
                                if (snapshot.hasData) {
                                  var isNumberLocked =
                                      false; //bool to check whether the pilot has already blocked the passenger.
                                  response = jsonDecode(snapshot.data);
                                  if (queue.isNotEmpty) {
                                    isNumberLocked = queue
                                        .contains(response['passengerPhone']);
                                  }
                                  if (!isNumberLocked &&
                                      (response['pilotPhone'] ==
                                          int.parse(HelperVariables.Phone))) {
                                    showRequest = true;
                                    playMusic();
                                  }
                                }
                                return Visibility(
                                  visible: showRequest,
                                  child: Material(
                                    type: MaterialType.button,
                                    borderRadius: BorderRadius.circular(25),
                                    elevation: 5,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: showRequest
                                                      ? '${response['passengerName']} '
                                                      : '',
                                                  style: const TextStyle(
                                                      fontSize: 17.5,
                                                      fontFamily: 'Nunito Sans',
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                                const TextSpan(
                                                    text: 'wants a ride to ',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                TextSpan(
                                                    text: showRequest
                                                        ? '${response['passengerDestination']}'
                                                            .toString()
                                                        : '',
                                                    style: const TextStyle(
                                                        fontSize: 15.85,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        fontWeight:
                                                            FontWeight.w900)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.50),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              RequestResponseWidget(
                                                color: Colors.red,
                                                response: 'Reject',
                                                onTap: () {
                                                  stopMusic();
                                                  queue.addFirst(response[
                                                      'passengerPhone']);
                                                  setState(() {
                                                    showRequest = false;
                                                  });
                                                },
                                              ),
                                              RequestResponseWidget(
                                                color: Colors.green,
                                                response: 'Accept',
                                                onTap: () async {
                                                  await acceptUser(
                                                      response['passengerPhone'],
                                                      response['pilotPhone'],
                                                      response['passengerDest']);
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder:
                                                        (BuildContext context) {
                                                      return PilotTrip(
                                                          destname: response[
                                                              'passengerDestination']);
                                                    }),
                                                  );

                                                  player.stop();
                                                  timer!.cancel();
                                                  deleteUser(int.parse(
                                                      HelperVariables.Phone));
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Center(
                          //     child: Padding(
                          //   padding: EdgeInsets.only(
                          //       bottom: SizeConfig.blockSizeVertical * 11),
                          //   child: Image.asset(
                          //     'assets/pi.png',
                          //     scale: 2.85,
                          //   ),
                          // )),
                          // Center(
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         bottom: SizeConfig.blockSizeVertical * 30),
                          //     child: Container(
                          //       height: SizeConfig.blockSizeVertical * 5,
                          //       width: SizeConfig.blockSizeHorizontal * 50,
                          //       decoration: BoxDecoration(
                          //           border: Border.all(
                          //               color: Colors.black, width: 1),
                          //           color: Colors.white.withOpacity(0.85)),
                          //       child: Material(
                          //         child: Center(
                          //           child: Consumer<MyModel>(
                          //               // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                          //               builder: (context, MyModel, child) {
                          //             return Text(
                          //               MyModel.username,
                          //               style: TextStyle(
                          //                   fontSize: 15,
                          //                   fontFamily: 'Nunito Sans',
                          //                   fontWeight: FontWeight.w500,
                          //                   color: Colors.black),
                          //             );
                          //           }),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
          )),
        ));
  }

  Future<void> _WayPoint() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          content: SizedBox(
              height: SizeConfig.safeBlockVertical * 8,
              width: SizeConfig.safeBlockHorizontal * 45,
              child: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  'Do you want to pick a specific route for your trip?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito Sans',
                      fontSize: 15),
                ),
              )),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.safeBlockVertical * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        wayPointMarkerLocked = true;
                      });

                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: SizedBox(
                        height: SizeConfig.safeBlockVertical * 6,
                        width: SizeConfig.safeBlockHorizontal * 17,
                        child: const Card(
                          color: Colors.black,
                          elevation: 5,
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        wayPointMarkerLocked = false;
                      });

                      _WayDirect();
                    },
                    child: Center(
                      child: SizedBox(
                        height: SizeConfig.safeBlockVertical * 6,
                        width: SizeConfig.safeBlockHorizontal * 17,
                        child: const Card(
                          color: Colors.black,
                          elevation: 5,
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _WayDirect() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          content: SizedBox(
              height: SizeConfig.safeBlockVertical * 8,
              width: SizeConfig.safeBlockHorizontal * 45,
              child: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  'Now tap on place on the map which you want to set as a waypoint!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito Sans',
                      fontSize: 14.5),
                ),
              )),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: SizedBox(
                  height: SizeConfig.safeBlockVertical * 6,
                  width: SizeConfig.safeBlockHorizontal * 17,
                  child: const Card(
                    color: Colors.black,
                    elevation: 5,
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito Sans',
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class RequestResponseWidget extends StatelessWidget {
  final String response;
  final Color color;
  final VoidCallback? onTap;

  const RequestResponseWidget(
      {required this.response, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      child: Material(
        borderRadius: BorderRadius.circular(25),
        elevation: 5,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            response,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontFamily: 'Nunito Sans',
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         ProviderTest.id: (_) => const ProviderTest(),
//       },
//       initialRoute: ProviderTest.id,
//     );
//   }
// }
//
// class ProviderTest extends StatefulWidget {
//   static var id = 'ProviderTest';
//
//   const ProviderTest({Key? key}) : super(key: key);
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _ProviderTestState createState() => _ProviderTestState();
// }
//
// class _ProviderTestState extends State<ProviderTest> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<MyModel>(
//       create: (BuildContext context) => GetModel(),
//
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.lightBlue,
//           title: const Text('Provider Test'),
//           centerTitle: true,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               color: Colors.lightBlue,
//               height: 200,
//               width: 300,
//               child: Consumer<MyModel>(
//                 // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//                 builder: (context, MyModel, child) {
//                   return Center(
//                     child: Text(
//                       MyModel.username,
//                       style: const TextStyle(color: Colors.black, fontSize: 15),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Consumer<MyModel>(
//               // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//               builder: (context, MyModel, child) {
//                 return ElevatedButton(onPressed: () {
//
//                 }, child: const Text('Press me'));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore: non_constant_identifier_names
GetModel() {
  return MyModel(username: 'Fetching Address...');
}

class MyModel with ChangeNotifier {
  String username;

  MyModel({required this.username});

  int a = 0;

  void doS(var lat, var lng) async {
    username = await getAddressFromLatLng(lat, lng);
    notifyListeners();
  }
}
