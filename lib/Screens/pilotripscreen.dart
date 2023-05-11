import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:veloce/Screens/passenger.dart';
import 'package:veloce/Screens/pilot.dart';
import 'package:veloce/Screens/splashscreen.dart';
import 'package:veloce/pilot_popup.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:veloce/sizeConfig.dart';
import 'package:http/http.dart' as http;
import '../Consts/constants.dart';
import '../Helper/HelperVariables.dart';
import '../api_otp_methods.dart';
import 'option.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

var showOTPs = false;
var rideStarted = false;

class PilotTrip extends StatefulWidget {
  static var id = 'PilotTripScreen';
  final String? destname;

  const PilotTrip({this.destname});

  @override
  _PilotTripState createState() => _PilotTripState();
}

class _PilotTripState extends State<PilotTrip> {
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? googleMapController;

/*
  LocationData? passengerCurrentLocation =
  LocationData.fromMap({'latitude': 23.14, 'longitude': 25.232});
  Deleted this
*/

  LocationData? pilotCurrentLocation;
  var image = HelperVariables.img_url;
  var Othername;
  var beta;
  int ent = 0;

  List<LatLng> polylineCoordinate = [];

  void getPolyPoint(double slat, double slong, double dlat, double dlong,
      var waypoint) async {

    print(slat.toString() +
        " " +
        slong.toString() +
        " " +
        dlat.toString() +
        " " +
        dlong.toString() +
        " ");
    polylineCoordinate.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      map_api_key,
      PointLatLng(slat, slong),
      PointLatLng(dlat, dlong),
      travelMode: TravelMode.driving,
      wayPoints: [
        PolylineWayPoint(
            location:
                (wayPointVal.latitude == 0.0 && wayPointVal.longitude == 0.0)
                    ? ""
                    : "${wayPointVal.latitude},${wayPointVal.longitude}",
            stopOver: false),
      ],
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinate.add(LatLng(point.latitude, point.longitude));
      }
      // setState(() {
      //   print("Entered setState");
      //    print(polylineCoordinate);
      // });
    }
  }

  WebSocketChannel? channel; //changed the var channel to WebSocketChannel
  void setLocations() {}
  var stream;

  // void setMarker() async {
  //   await BitmapDescriptor.fromAssetImage(
  //           const ImageConfiguration(size: Size(0, 0)), 'assets/src1.png')
  //       .then((icon) {
  //     setState(() {
  //       customMarker = icon;
  //     });
  //   });
  // }

  Future<void> closeSocket(int phone) async {
    var response = await http
        .get(Uri.parse('http://139.59.44.53/closeTheConnection?phone=$phone'));
    var data = jsonDecode(response.body);
    print(data);
  }

  Future<void> deleteFromIds(int phone) async {
    var response = await http
        .get(Uri.parse('http://139.59.44.53/deleteFromIds?phone=$phone'));

    print(response.body);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double ans = 0;
  var waypoint;
  double end = 0;
  bool _isLoading = true;
  bool _internetStat = true;
  List<int> otp = [
    Random().nextInt(9),
    Random().nextInt(9),
    Random().nextInt(9),
    Random().nextInt(9)
  ];

  void getlocation() async {
    Location location = Location();

    await location.getLocation().then((location) {
      pilotCurrentLocation = location;
      print("${HelperVariables.otherPhone}+HelperVariables.otherPhone");
      channel!.sink.add(jsonEncode({
        'to': HelperVariables.otherPhone,
        'location': [location.latitude, location.longitude]
      }));
    });

    location.onLocationChanged.listen((newLoc) async {
      if (!mounted) return;
      channel!.sink.add(json.encode({
        'to': HelperVariables.otherPhone,
        'location': [newLoc.latitude, newLoc.longitude]
      }));
      pilotCurrentLocation = newLoc;
      ans = calculateDistance(pilotCurrentLocation!.latitude!,
          pilotCurrentLocation!.longitude!, data[0], data[1]);
      end = calculateDistance(
          pilotCurrentLocation!.latitude!,
          pilotCurrentLocation!.longitude!,
          HelperVariables.passengerDest[0],
          HelperVariables.passengerDest[1]);
      if (rideStarted && ent == 0) {
        getPolyPoint(
            pilotCurrentLocation!.latitude!,
            pilotCurrentLocation!.longitude!,
            HelperVariables.passengerDest[0],
            HelperVariables.passengerDest[1],
            wayPointVal);
        channel!.sink.add(jsonEncode(
            {'to': HelperVariables.otherPhone, 'location': "started"}));
        ent = 1;

        setState(() {
          print(polylineCoordinate);
        });
      }
      void postFunc() async {
        // _internetStat = await isInternet();
        // if (_internetStat == false) {
        //   setState(() {
        //     _internetStat = false;
        //   });
        //   return;
        // }
        // print(_internetStat);
        var _apiResponse = await OtpMethods().postOtp(pilot:int.parse(HelperVariables.Phone),passenger:int.parse(HelperVariables.Phone) ,otp: int.parse(otp.join('')));
        if (_apiResponse == 200) {
          setState(() {
            _isLoading = false;
          });
        }
      }

      Future<void> _EndDialog() async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            dialogContexts = context;
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(
                        child: Column(
                          children: [
                            Text(
                                'Your ride is completed! \nPlease enter the OTP shared by Pilot'),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 10,
                              width: SizeConfig.safeBlockHorizontal * 73,
                              child: _isLoading == true
                                  ? Center(
                                  child: _internetStat == true
                                      ? CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                      : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.signal_wifi_connected_no_internet_4,
                                        size: SizeConfig.safeBlockVertical * 5,
                                      ),
                                      Text(
                                        "No internet",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'NunitoSans',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ))
                                  : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 4,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(10),
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Card(
                                        color: Colors.white.withOpacity(0.85),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)),
                                        child: SizedBox(
                                            width: SizeConfig.safeBlockHorizontal * 15,
                                            child: Center(
                                                child: Text(
                                                  "${otp[index]}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: 'NunitoSans',
                                                      fontSize: 20),
                                                ))),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }

      print(ans);
      print(rideStarted.toString() + "thois is ride starteed");
      if (!mounted) return;
      if (ans <= 0.075 && !rideStarted) {
        if (!mounted) return;
        setState(() {
          showOTPs = true;
        });
      } else if (end <= 0.075) {
        _EndDialog();
      }
    });
  }

  @override
  void dispose() {
    print("Entered dispose");
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    print("Entered deactivate");
    // TODO: implement deactivate
    super.deactivate();
  }

  var dialogContexts;

  Future<void> _Cancel() async {
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
                  'Are you sure you want to cancel the ride?',
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
                      channel!.sink.add(jsonEncode({
                        'to': HelperVariables.otherPhone,
                        'location': "cancel"
                      }));
                      Navigator.pushNamedAndRemoveUntil(context,Options.id, (route) => false);
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

  void initailizeWebsocket() async {
    channel = WebSocketChannel.connect(
        Uri.parse('ws://139.59.44.53:3005?phone=${HelperVariables.Phone}'));
    //   try {
    //     channel = WebSocketChannel.connect(
    //         Uri.parse('ws://139.59.44.53:3005?phone=${HelperVariables.Phone}'));
    setState(() {
      stream = channel!.stream;
    });
    //     // send initial data
    //   } catch (e) {
    //     print('Error connecting to WebSocket: $e');
    //   }
    //   // channel.sink.add(HelperVariables.passengercurrentLocation);
    //   // stream = channel.stream;
    //   channel!.stream.listen((event) {
    //     print('kuch aaya00');
    //     print("${jsonDecode(event)[0]}");
    //     print(event.runtimeType);
    //
    //   });
    print("exitted websocekt method ");
    // }
    //
    // Stream<String> initailizeWebsocket() {
    //   channel = WebSocketChannel.connect(
    //       Uri.parse('ws://139.59.44.53:3005?phone=${HelperVariables.Phone}'));
    //   // channel!.sink.add(HelperVariables.pilotcurrentLocation);
    //
    //   // channel!.stream.listen((event) {
    //   //   passengerCurrentLocation.latitude != jsonDecode(event)[0];
    //   //   passengerCurrentLocation.longitude != jsonDecode(event)[1];
    //   //   print(jsonDecode(event)[0]);
    //   //   print('this is soem ${passengerCurrentLocation.latitude!}');
    //   // });
    //   print("exitted websocekt method ");
    //   return channel!.stream.map((event) => event);
  }

  var load = false;

  void getDataOfOtherUser() async {
    var response = await http.get(Uri.parse(
        'http://167.71.238.162/users/user?phone=${HelperVariables.otherPhone}'));
    var data = jsonDecode(response.body);

    setState(() {
      Othername = data[0]['name'];
      image = data[0]['image'];
    });
    print(Othername);
    print(image);
  }

  void initializeMaps() async {
    googleMapController = await _mapController.future;
    print("Enterd ");
  }

  @override
  void initState() {
    initializeMaps();
    // print('1 ${HelperVariables.pilotcurrentLocation}');
    //
    // setState(() {
    pilotCurrentLocation = HelperVariables.pilotcurrentLocation;
    // });
    print("2");
    initailizeWebsocket();
    print("3");
    Future.delayed(Duration(seconds: 2), () {
      getlocation();
    });
    Future.delayed(Duration(seconds: 2), () {
      getDataOfOtherUser();
    });
    print("4");
    deleteFromIds(int.parse(HelperVariables.Phone));

    // getDataOfOtherUser();
    // setMarker();
    // TODO: implement initState
    super.initState();
  }

  var data = [30.8, 78.3];

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        dialogContexts = context;
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Center(
                    child: Text('Sorry,your passenger has canceled the ride!'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  var checkOnce=0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: SizeConfig.safeBlockVertical * 100,
                width: SizeConfig.safeBlockHorizontal * 100,
                color: Colors.white,
                child: Stack(children: [
                  //First here it was sizedbox and column but now I haved added only Container

                  Container(
                    child: StreamBuilder(
                        stream: stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          print("This is a test using StreamBuilder!");
                          if (snapshot.hasData) {
                            var val;
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                val = jsonDecode(snapshot.data);
                                if (val == 'cancel' && checkOnce == 0)  {
                                  _showMyDialog();
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.pushNamedAndRemoveUntil(context,Options.id, (route) => false);
                                  });

                                  channel!.sink.close();
                                  checkOnce=1;
                                }
                               else if(val=='end' ){
                                    Navigator.pushNamedAndRemoveUntil(context, Options.id, (route) => false);
                                }
                               else {
                                  data[0] = val[0];
                                  data[1] = val[1];
                                }
                              });
                            });
                          }
                          print("the value of data is $data");
                          return Text('');
                        }),
                  ),
                  SizedBox(
                      height: SizeConfig.safeBlockVertical * 100,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 87,
                            width: SizeConfig.safeBlockHorizontal * 100,
                            child: GoogleMap(
                              myLocationEnabled: true,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: true,
                              buildingsEnabled: false,
                              compassEnabled: true,
                              onCameraIdle: () async {
                                //   // LatLngBounds bounds =
                                //   //     await googleMapController!.getVisibleRegion();
                                //   // final lon = (bounds.northeast.longitude +
                                //   //         bounds.southwest.longitude) /
                                //   //     2;
                                //   // final lat = (bounds.northeast.latitude +
                                //   //         bounds.southwest.latitude) /
                                //   //     2;
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      pilotCurrentLocation!.latitude!,
                                      pilotCurrentLocation!.longitude!),
                                  zoom: 17.5),
                              mapType: MapType.normal,
                              polylines: {
                                const Polyline(
                                    polylineId: PolylineId('PassengerRoute'),
                                    color: Colors.lightBlueAccent,
                                    width: 5),
                                Polyline(
                                    polylineId: PolylineId('PilotsRoute'),
                                    color: Colors.black,
                                    points: polylineCoordinate,
                                    width: 5),
                              },
                              markers: {
                                Marker(
                                    markerId: const MarkerId('Center'),
                                    icon: BitmapDescriptor.defaultMarker,
                                    position: LatLng(data[0], data[1]),
                                    draggable: true,
                                    zIndex: 25)
                              },
                              onMapCreated: (mapController) {
                                setState(() {
                                  _mapController.complete(mapController);
                                });
                              },
                            ),
                          ),
                          Container(
                            height: SizeConfig.safeBlockVertical * 13,
                            width: SizeConfig.safeBlockHorizontal * 100,
                            color: Colors.white,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: SizeConfig.safeBlockVertical * 10,
                                  width: SizeConfig.safeBlockHorizontal * 30,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage('$image'),
                                          // 'https://imagebr.nyc3.cdn.digitaloceanspaces.com/$image'),
                                          fit: BoxFit.fill)),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          '$Othername',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    print("Entered the cancel ride secttion");
                                    await _Cancel();
                                    await closeSocket(
                                        int.parse(HelperVariables.Phone));
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                    elevation: 5,
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Cancel ride!',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),

                  Positioned(
                    left: SizeConfig.safeBlockHorizontal * 2.5,
                    right: SizeConfig.safeBlockHorizontal * 2.5,
                    top: SizeConfig.safeBlockVertical * 13.5,
                    child: Center(
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(10.50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.my_location_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "widget.destname!",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: showOTPs,
                      child: Center(
                        child: PilotPopupDialog(
                          pilot: int.parse(HelperVariables.Phone),
                          passenger: HelperVariables.otherPhone,
                        ),
                      ))
                ]),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
