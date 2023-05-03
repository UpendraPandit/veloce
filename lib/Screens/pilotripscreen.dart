import 'dart:async';
import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:veloce/sizeConfig.dart';
import 'package:http/http.dart' as http;
import '../Helper/HelperVariables.dart';

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
      channel!.sink.add(json.encode({
        'to': HelperVariables.otherPhone,
        'location': [newLoc.latitude, newLoc.longitude]
      }));
      pilotCurrentLocation = newLoc;
    });
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
                child: Stack(children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 100,
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: Column(
                      children: [
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
                                     val =
                                         jsonDecode(snapshot.data);
                                     data[0] = val[0];
                                     data[1] = val[1];

                                   });
                                    });
                                }
                                print("the value of data is $data");
                                return Text('');
                              }),
                        ),
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
                                const Polyline(
                                    polylineId: PolylineId('PilotsRoute'),
                                    color: Colors.black,
                                    width: 5),
                              },
                              markers: {
                                Marker(
                                    markerId: const MarkerId('Center'),
                                    icon: BitmapDescriptor.defaultMarker,
                                    position: LatLng(data[0],data[1]),
                                    draggable: true,
                                    zIndex: 25)
                              },
                              onMapCreated: (mapController) {
                                setState(() {
                                  _mapController.complete(mapController);
                                });
                              },
                            )),
                        Container(
                          height: SizeConfig.safeBlockVertical * 10,
                          width: SizeConfig.safeBlockHorizontal * 100,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              GestureDetector(
                                onTap: () async {
                                  await closeSocket(
                                      int.parse(HelperVariables.Phone));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFE21608),
                                  elevation: 5,
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'Cancel!',
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
                    ),
                  ),
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
                      )),
                ]),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
