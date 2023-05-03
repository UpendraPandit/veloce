import 'dart:async';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:veloce/sizeConfig.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Helper/HelperVariables.dart';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:veloce/Consts/constants.dart';

class PassengerTrip extends StatefulWidget {
  static var id = 'PassengerTripScreen';
  final int? phone;
  final String? destiname;

  const PassengerTrip({this.destiname, this.phone});

  @override
  _PassengerTripState createState() => _PassengerTripState();
}

class _PassengerTripState extends State<PassengerTrip> {
  var pCoordinates;
  List<LatLng> polylineCoordinates = [];
  LocationData? passengerCurrentLocation;
  LocationData? pilotLocation;
  var image = HelperVariables.img_url;
  var beta;
  var Othername;

  void setLocations() {}
  WebSocketChannel? channel;//Changed the var channel to WebSocketChannel
  var stream;
  double distance = 0;
  double sum = 0;
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? googleMapController;

  void setMarker() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(0, 0)), 'assets/src1.png')
        .then((icon) {
      setState(() {
        customMarker = icon;
      });
    });
  }
 @override
  void dispose() {

    // TODO: implement dispose
    // googleMapController!.dispose();
    super.dispose();
  }
  void getPolyPoints(double dlat, double dlong) async {
    polylineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      map_api_key,
      PointLatLng(passengerCurrentLocation!.latitude!,
          passengerCurrentLocation!.longitude!),
      PointLatLng(dlat, dlong),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
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

    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void getlocations() async {
    Location location = Location();


location.getLocation().then((location)async {
  passengerCurrentLocation = location;
  print("Location $location");
  print("passengerLocation $passengerCurrentLocation");
  print("${widget.phone}+Helpervearoanles");
  channel!.sink.add(jsonEncode({
    'to': widget.phone,
    'location': [location.latitude,location.longitude]
  }));
});
    // googleMapController = await _mapController.future;
    location.onLocationChanged.listen((newLoc) {

      //newLoc.latitude,newLoc.longitude
      channel!.sink.add(jsonEncode({
        'to': widget.phone,
        'location': [newLoc.latitude,newLoc.longitude]
      }));
      //commented setState
      // setState(() {
        passengerCurrentLocation = newLoc;
      // });
    });
  }


  void initailizeWebsocket() async {
    channel = WebSocketChannel.connect(
        Uri.parse('ws://139.59.44.53:3005?phone=${HelperVariables.Phone}'));

    // channel.sink.add(HelperVariables.passengercurrentLocation);
    setState(() {
      stream = channel!.stream;
    });

    // channel!.stream.listen((event) {
    //   print('kuch aaya00');
    //   print("${jsonDecode(event)[0]}");
    //   print(event.runtimeType);
    //
    // });
 print("exitted websocekt method ");
  }

  Future<void> deleteFromIds(int phone) async {
    var response = await http
        .get(Uri.parse('http://139.59.44.53/deleteFromIds?phone=$phone'));
    print(response.body);
  }



  Future<void> closeSocket(int phone) async {
    var response = await http
        .get(Uri.parse('http://139.59.44.53/closeTheConnection?phone=$phone'));
    var data = jsonDecode(response.body);
    print(data);
  }

  @override
  void deactivate() {
    print('Entered deactivate function');
    closeSocket(int.parse(HelperVariables.Phone));
    // TODO: implement deactivate
    super.deactivate();
  }

  void getDataOfOtherUser()async
  {
    var response = await http.get(Uri.parse('http://167.71.238.162/users/user?phone=${widget.phone}'));
     var data = jsonDecode(response.body);
      print(data);
    setState(() {
      Othername=data[0]['name'];
      image=data[0]['image'];

    });
     print(Othername);
     print(image);

  }
  void controllerInitializer()async {
    googleMapController = await _mapController.future;
    print("Enterd ");
  }
  var load=false;
  @override
  void initState() {
    passengerCurrentLocation=HelperVariables.passengercurrentLocation;
    controllerInitializer();
    initailizeWebsocket();
    Future.delayed(Duration(seconds: 2),(){  getlocations();
    });

    Future.delayed(Duration(seconds: 2),(){
      getDataOfOtherUser();
    });
      deleteFromIds(int.parse(HelperVariables.Phone));

    // getDataOfOtherUser();


    // TODO: implement initState
    super.initState();

  }
  var data=[30.8,78.3];
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
                                // LatLngBounds bounds =
                                //     await googleMapController!.getVisibleRegion();
                                // final lon = (bounds.northeast.longitude +
                                //         bounds.southwest.longitude) /
                                //     2;
                                // final lat = (bounds.northeast.latitude +
                                //         bounds.southwest.latitude) /
                                //     2;
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      passengerCurrentLocation!.latitude!,
                                      passengerCurrentLocation!.longitude!),
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
                                    position:LatLng(data[0], data[1]),
                                    draggable: true,
                                    zIndex: 25)
                              },
                              onMapCreated: (mapController) {
                                setState(() {
                                  _mapController.complete(mapController);

                                });
                              },
                            )
                        ),
                        Container(
                          height: SizeConfig.safeBlockVertical * 13,
                          width: SizeConfig.safeBlockHorizontal * 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                height: SizeConfig.safeBlockVertical * 10,
                                width: SizeConfig.safeBlockHorizontal * 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '$image'),
                                        fit: BoxFit.fill)),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    child:  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        '$Othername',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 25,),
                              GestureDetector(
                                onTap: () async {
                                  await closeSocket(
                                      int.parse(HelperVariables.Phone));
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(
                                Icons.my_location_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "widget.destiname!",
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
                ]),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

class Dotted extends StatelessWidget {
  const Dotted({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 1,
      height: SizeConfig.safeBlockVertical * 1,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
