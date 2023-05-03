import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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
import 'package:veloce/Screens/passengertripscreen.dart';
import 'package:veloce/sizeConfig.dart';
import 'package:dart_geohash/dart_geohash.dart';

import 'package:lottie/lottie.dart' as lottie;
import 'package:web_socket_channel/web_socket_channel.dart';

// import 'package:geolocator/geolocator.dart';
bool polyCheck = false;
bool destWidgetCheck = false;

class PassengerScreen extends StatefulWidget {
  static var id = 'PassengerScreen';

  const PassengerScreen({Key? key}) : super(key: key);

  //API key: AIzaSyCScR-fqEvQ3t_tQtnX_nVo7Ir1e5AzhNQ
  @override
  _PassengerScreenState createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  // static double slat = double.parse(FirstScreen.lat);
  // static double slong = double.parse(FirstScreen.long);
  //

  // static double dlat = 30.2968691;
  // static double dlong = 78.0019436;
  late LatLng src =
  LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

  static LatLng des = const LatLng(-30.2968691, -30.2968691);

  // final TextEditingController _destinationController = TextEditingController();
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor srcIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  String searchLocation = "SearchLocation";
  var passengerStream;
  var phone;
  bool itcheck = false;
  var isSourceChecked = false;
  var currentLoc;
  var pickupbottom = 80.0;
  var pickupleft = 20.0;
  var dropbottom = 18.0;
  var dropleft = 20.0;
  double distance = 0;
  double sum = 0;
  bool isDestandSrcSet = false;
  GoogleMapController? googleMapController;
  var LatLngIterator;
  bool isSentOnce = false;
  bool showPlaceSearch = true;

  Timer? waitingTime;

  Future imageReturn() {
    return BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'currLoc.json');
  }

  String getGeoHashedValue(LatLng loc) {
    var geohasher = GeoHasher();
    var val = geohasher.encode(loc.longitude, loc.latitude, precision: 6);
    return val;
  }

  void getUserInfo() async {
    var res = await http.get(Uri.parse(
        'http://167.71.238.162/users/user?phone=${HelperVariables.Phone}'));
    var data = jsonDecode(res.body);
    print(data);
  }

  void setIcon() async {
    await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(39, 15)), 'assets/ldk.png')
        .then((icon) {
      setState(() {
        srcIcon = icon;
      });
    });
    await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(45, 45)), 'assets/ldk.png')
        .then((icon) {
      setState(() {
        // destinationIcon = icon;
      });
    });
    // await  BitmapDescriptor.fromAssetImage(
    //          ImageConfiguration(
    //            size: Size(12,12)
    //          ),
    //           'assets/ic.png')
    //       .then((icon) {
    //     setState(() {
    //       sourceIcon = icon;
    //     });
    //   });
  }

  void waitForPilotResponse() {
    waitingTime = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!mounted) {
        return;
      }
      SearchAgainForPilot();
      timer.cancel();
    });
  }

  void getLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
    googleMapController = await _mapController.future;

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) {
        return;
      }


      setState(() {
        //remember to remove these two
        HelperVariables.passengercurrentLocation = currentLocation;
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
              // polylineCoordinates.clear();C:\platform-tools
              // getPolyPoints(des.latitude, des.longitude);
            });
          }
          // print('object');
          // print(polylineCoordinates);
          //    LatLng it=  polylineCoordinates.iterator.current??src;
          //       print('Iterator value $it');
          //       print('Current location is $currentLocation');
        }

        //     getPolyPoints(des.latitude, des.longitude);
      });
    });
  }

  void getPolyPoints(double dlat, double dlong) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      map_api_key,
      PointLatLng(src.latitude, src.longitude),
      PointLatLng(dlat, dlong),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
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

  void sendPassengerLocation() async {
    var currLocation = getGeoHashedValue(src);
    var geohasher = GeoHasher();
    var destination =
    geohasher.encode(des.longitude, des.latitude, precision: 6);
    Uri url;
    if (!isSentOnce) {
      url = Uri.parse('http://139.59.44.53/passengers/pushNewUser');
    } else {
      url = Uri.parse('http://139.59.44.53/passengers/updateUser');
    }

    Map<String, String> header = {
      'Content-Type': 'application/json',
    };
    final msg = jsonEncode({
      "name": HelperVariables.Name,
      "phone": int.parse(HelperVariables.Phone),
      "gender": HelperVariables.gender,
      "currLoc": currLocation,
      "destination": searchLocation,
    });
    var response = await (isSentOnce
        ? http.put(url, body: msg, headers: header)
        : http.post(url, body: msg, headers: header));
    searchPilot();
    print(response.body);
  }

  void deleteUser(int phone) async {
    var url =
    Uri.parse('http://139.59.44.53/passengers/deleteUser?phone=$phone');
    var resp = await http.delete(url);
    print(resp.body);
  }

  void searchPilot() async {
    var url = Uri.parse(
        'http://139.59.44.53/passengers/getpilot?long=${des.longitude}&lat=${des
            .latitude}&currLong=${src.longitude}&currLat=${src
            .latitude}&phone=${HelperVariables.Phone}');
    var resp = await http.get(url);
    print('searchResponse ${resp.body}');
  }

  void initailizePassengerWebsocket() async {
    final channel =
    WebSocketChannel.connect(
        Uri.parse('ws://139.59.44.53:3001?phone=${HelperVariables.Phone}'));
    channel.sink.add("Hello From flutter");
    setState(() {
      passengerStream = channel.stream;
    });

  }

  @override
  void initState() {
    getUserInfo();
    getLocation();
    setIcon();
    initailizePassengerWebsocket();


    // TODO: implement initState
    super.initState();
  }

//   void getDistance()
//   {
//     print("Distance function entered");
//     final  ltlng.Distance distance = new ltlng.Distance();
//     final num km =  distance.as(ltlng.LengthUnit.Kilometer, ltlng.LatLng(src.latitude, src.longitude),ltlng.LatLng(src.latitude, src.longitude));
// print(km);
//
//   }
//   double getDistance()
//   {
//     print('enter distance function');
//     // final double distance =Geolocator.distanceBetween(src.latitude, src.longitude, des.longitude,des.longitude);
//     // print(distance.round());
//     // return distance;
//   }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
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
              child: Container(
                height: SizeConfig.safeBlockVertical * 100,
                width: SizeConfig.safeBlockHorizontal * 100,
                color: const Color(0xFFDFE1F3),
                child: Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 100,
                        width: SizeConfig.safeBlockHorizontal * 100,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          buildingsEnabled: false,
                          myLocationEnabled: true,
                          tiltGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: src,
                            zoom: 17.5,
                          ),
                          polylines: {
                            Polyline(
                              polylineId: const PolylineId("route"),
                              points: polylineCoordinates,
                              color: Colors.black,
                              width: 5,
                            ),
                          },
                          markers: {
                            // Marker(
                            //   markerId: const MarkerId('source'),
                            //   position:LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
                            //   icon: BitmapDescriptor.defaultMarkerWithHue(210),
                            // ),
                            Marker(
                              markerId: const MarkerId('current Location'),
                              position: src,
                              consumeTapEvents: true,
                              // position: LatLng(currentLocation!.latitude!,
                              //     currentLocation!.longitude!),
                              icon: srcIcon,
                            ),
                            Marker(
                                markerId: const MarkerId('destination'),
                                position: des,
                                icon: destinationIcon),
                          },
                          onMapCreated: (mapController) {
                            setState(() {
                              _mapController.complete(mapController);
                            });
                          },
                        ),
                      ),
                      Container(
                        child: Column(
                          children: const [
                            // Container(
                            //   color: Colors.black,
                            //   height: SizeConfig.safeBlockVertical * 4.5,
                            //   width: SizeConfig.safeBlockHorizontal * 25,
                            //   child: Center(
                            //       child: Text(
                            //         '$distance km',
                            //         style: const TextStyle(
                            //           fontFamily: 'Nunito Sans',
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.white,
                            //         ),
                            //       )),
                            // ),
                            // SizedBox(
                            //   height: SizeConfig.safeBlockVertical * 1,
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     sendPassengerLocation();
                            //   },
                            //   child: const Material(
                            //     color: Colors.black,
                            //     child: Padding(
                            //       padding: EdgeInsets.all(10.0),
                            //       child: Text(
                            //         'Search me a ride',
                            //         style: TextStyle(
                            //           fontFamily: 'Nunito Sans',
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: showPlaceSearch,
                    child: Positioned(
                      bottom: pickupbottom,
                      left: pickupleft,
                      child: InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: map_api_key,
                              overlayBorderRadius: BorderRadius.circular(25),
                              logo: Container(
                                width: SizeConfig.safeBlockHorizontal * 100,
                                height: SizeConfig.safeBlockVertical * 7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25)),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      src = LatLng(currentLocation!.latitude!,
                                          currentLocation!.longitude!);
                                      Navigator.pop(context);
                                      //Commented setState here
                                      // setState(() {
                                        isSourceChecked = true;
                                      // });
                                      print(src);
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                        SizeConfig.safeBlockHorizontal *
                                            5,
                                      ),
                                      const Icon(
                                        Icons.gps_fixed,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width:
                                        SizeConfig.safeBlockHorizontal *
                                            5,
                                      ),
                                      const Text(
                                        'Use current location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Nunito Sans',
                                            fontSize: 16.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              decoration: const InputDecoration(
                                  counterStyle:
                                  TextStyle(fontWeight: FontWeight.w900)),
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
                              searchLocation = place.description.toString();
                              setState(() {
                                isSourceChecked = true;
                              });
                            });
                            final plist = gmws.GoogleMapsPlaces(
                              apiKey: map_api_key,
                              apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                            );
                            String placeId = place.placeId ?? "0";
                            print(placeId);
                            final detail =
                            await plist.getDetailsByPlaceId(placeId);
                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final long = geometry.location.lng;
                            setState(() {
                              src = LatLng(lat, long);
                              polylineCoordinates.clear();
                              googleMapController!.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                          bearing: 45,
                                          zoom: 17.5,
                                          tilt: 1.2,
                                          target: src)));
                            });
                          }
                        },
                        child: destWidgetCheck
                            ? Center(
                          child: SizedBox(
                              height: SizeConfig.safeBlockVertical * 7,
                              width:
                              SizeConfig.safeBlockHorizontal * 14,
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
                            : Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 2),
                          width: SizeConfig.safeBlockHorizontal * 75,
                          height: SizeConfig.safeBlockVertical * 7.5,
                          child: Card(
                            color: Colors.black.withOpacity(1),
                            elevation: 5,
                            child: const Center(
                              child: Text(
                                'Pick up',
                                style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // child: TextFormField(
                            //   controller: _destinationController,
                            //   // textAlign: TextAlign.center,
                            //   style: const TextStyle(
                            //       fontFamily: 'Nunito Sans',
                            //       fontWeight: FontWeight.w600,
                            //       fontSize: 17),
                            //   decoration: const InputDecoration(
                            //     prefixText: '  ',
                            //     hintText: 'Enter your destination',
                            //     // hintStyle: TextStyle(),
                            //     border: InputBorder.none,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(
                  //       SizeConfig.safeBlockHorizontal * 60.0, 0, 0, 0),
                  //   height: SizeConfig.safeBlockVertical * 6,
                  //   width: SizeConfig.safeBlockHorizontal * 30,
                  //   child: Card(
                  //       elevation: 3.5,
                  //       child: Material(
                  //         child: InkWell(
                  //           onTap: () {},
                  //           splashColor: Colors.blue,
                  //           child: const Center(
                  //               child: Text(
                  //             'GO',
                  //             style: TextStyle(
                  //                 fontFamily: 'Nunito Sans',
                  //                 fontWeight: FontWeight.w600,
                  //                 fontSize: 17),
                  //           )),
                  //         ),
                  //       )),
                  // ),

                  // Dotted(),
                  // Dotted(),
                  // Dotted(),
                  Visibility(
                    visible: showPlaceSearch,
                    child: Positioned(
                      bottom: dropbottom,
                      left: dropleft,
                      child: InkWell(
                          onTap: () async {
                            if (isSourceChecked == false) {
                              _SourceError();
                            } else {
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
                                  apiKey: map_api_key,
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
                                });
                                googleMapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: newLatLng, zoom: 17.5)));
                                polylineCoordinates.clear();
                                getPolyPoints(des.latitude, des.longitude);
                                polyCheck = true;
                                destWidgetCheck = true;
                                setState(() {
                                  pickupbottom =
                                      SizeConfig.safeBlockVertical * 90;
                                  pickupleft =
                                      SizeConfig.safeBlockHorizontal * 85;
                                  dropbottom =
                                      SizeConfig.safeBlockVertical * 80;
                                  dropleft =
                                      SizeConfig.safeBlockHorizontal * 85;
                                  isDestandSrcSet = true;
                                });
                              }
                            }
                          },
                          child: destWidgetCheck
                              ? Center(
                            child: SizedBox(
                                height:
                                SizeConfig.safeBlockVertical * 7,
                                width:
                                SizeConfig.safeBlockHorizontal * 14,
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
                            height: SizeConfig.safeBlockVertical * 7,
                            width: SizeConfig.safeBlockHorizontal * 75,
                            child: Card(
                                color: Colors.black.withOpacity(1),
                                elevation: 5,
                                child: const Center(
                                  child: Text(
                                    'Drop',
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
                    visible: isDestandSrcSet,
                    child: Positioned(
                        bottom: SizeConfig.safeBlockVertical * 2,
                        left: SizeConfig.safeBlockHorizontal * 9,
                        child: SizedBox(
                          height: SizeConfig.safeBlockVertical * 7,
                          width: SizeConfig.safeBlockHorizontal * 70,
                          child: Card(
                              color: Colors.black.withOpacity(1),
                              elevation: 5,
                              child: InkWell(
                                onTap: () {
                                  showWaitingTimeDialog();
                                  sendPassengerLocation();
                                  // initailizePassengerWebsocket();
                                  setState(() {
                                    isSentOnce = true;
                                    showPlaceSearch = false;
                                  });
                                },
                                child: const Material(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Text(
                                      'Search me a ride',
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        )),
                  ),
                  Positioned(
                      child: StreamBuilder(
                        stream: passengerStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            var response = jsonDecode(snapshot.data);
                            if (response['passenger'] ==
                                int.parse(HelperVariables.Phone)) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {



                                  deleteUser(int.parse(HelperVariables.Phone));
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PassengerTrip(
                                                phone: response['pilot'],
                                                destiname:searchLocation
                                            );
                                          }), (route) => false);

                                });

                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ))
                ]),
              ),
            ),
          )),
    );
  }

  Future<void> showWaitingTimeDialog() async {
    waitForPilotResponse();
    BuildContext dialogContext;

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;

          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                content: SizedBox(
                    height: SizeConfig.safeBlockVertical * 12,
                    width: SizeConfig.safeBlockHorizontal * 45,
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 9,
                          width: SizeConfig.safeBlockHorizontal * 100,
                          child: Material(
                            color: Colors.transparent,
                            child: Center(
                              child: lottie.Lottie.asset('assets/helmet.json'),
                            ),
                          ),
                        ),
                        const Material(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              'Searching for the best ride!',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    )),
              ));
        });
  }

  Future<void> SearchAgainForPilot() async {
    BuildContext dialogContext;
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dialogContext = context;
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              content: SizedBox(
                height: SizeConfig.safeBlockVertical * 17,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 9,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                          child: Image.asset('assets/flat.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    const Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          'Uh oh! We could not find any ride. ',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.safeBlockVertical * 1.25),
                  child: GestureDetector(
                    onTap: () {
                      showWaitingTimeDialog();
                      searchPilot();
                      Navigator.of(context).pop();
                      Navigator.pop(dialogContext);
                    },
                    child: Center(
                      child: SizedBox(
                        height: SizeConfig.safeBlockVertical * 6,
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: const Card(
                          color: Colors.black,
                          elevation: 5,
                          child: Center(
                            child: Text(
                              'Search Again',
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
                )
              ],
            ),
          );
        });
  }

  Future<void> _SourceError() async {
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
              child: const Material(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    'Please first enter pickup!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans',
                        fontSize: 17.5),
                  ),
                ),
              )),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: SizedBox(
                  height: SizeConfig.safeBlockVertical * 5,
                  width: SizeConfig.safeBlockHorizontal * 16,
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
            )
          ],
        );
      },
    );
  }
}

class Dotted extends StatelessWidget {
  const Dotted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 1.5,
      height: SizeConfig.safeBlockVertical * 1.5,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
