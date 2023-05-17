import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:veloce/Profile/first.dart';
import 'package:veloce/Screens/passenger.dart';
import 'package:veloce/Screens/splashscreen.dart';
import 'package:veloce/passenger_popup.dart';
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
import '../api_otp_methods.dart';
import 'cross_feedback.dart';
import 'pilotripscreen.dart';
import 'option.dart';

var showOTP = false;
List<LatLng> polylineCoordinate = [];

class PassengerTrip extends StatefulWidget {
  static var id = 'PassengerTripScreen';
  final int? phone;
  final String? destiname;
  final waypoint;

  const PassengerTrip({this.destiname, this.phone, this.waypoint});

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
  WebSocketChannel? channel; //Changed the var channel to WebSocketChannel
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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double ans = 0;
  double end = 0;
  int ent = 0;
  int once = 0;

  void getPolyPoint(
      double slat, double slong, double dlat, double dlong) async {
    if (once == 1) return;
    once = 1;
    print("The value of once is:$once");
    print("Trying to print runtime type");
    // print(widget.waypoint.longitude);
    print(widget.waypoint[0].runtimeType);

    polylineCoordinate.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      map_api_key,
      PointLatLng(slat, slong),
      PointLatLng(dlat, dlong),
      travelMode: TravelMode.driving,
      wayPoints: [
        PolylineWayPoint(
            location: (widget.waypoint[0] == 0 && widget.waypoint[1] == 0)
                ? ""
                : "${widget.waypoint[0]},${widget.waypoint[1]}",
            stopOver: false),
      ],
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinate.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  void getlocations() async {
    Location location = Location();
    // if(!mounted)return;
    //used await here
    await location.getLocation().then((location) async {
      passengerCurrentLocation = location;
      print("Location $location");
      print("passengerLocation $passengerCurrentLocation");
      print("${widget.phone}+Helpervearoanles");
      channel!.sink.add(jsonEncode({
        'to': widget.phone,
        'location': [location.latitude, location.longitude]
      }));
    });
    // googleMapController = await _mapController.future;

    location.onLocationChanged.listen((newLoc) {
      if (!mounted) return;
      channel!.sink.add(jsonEncode({
        'to': widget.phone,
        'location': [newLoc.latitude, newLoc.longitude]
      }));
      //commented setState
      // setState(() {
      passengerCurrentLocation = newLoc;
      ans = calculateDistance(passengerCurrentLocation!.latitude!,
          passengerCurrentLocation!.longitude!, data[0], data[1]);
      end = calculateDistance(
          passengerCurrentLocation!.latitude!,
          passengerCurrentLocation!.longitude!,
          PassengerScreen.des.latitude,
          PassengerScreen.des.longitude);
    print("printing end $end");
      if (!mounted) return;
      if (ans <= 0.075 && !rideStarted) {
        setState(() {
          showOTP = true;
          print("Printing the widget.phone ${widget.phone!}");
        });
      } else if (end <= 0.075 &&checkEnd == 0) {
        _EndDialog();
        checkEnd=1;
        print(checkEnd);
      }
      // });
    });
  }
  var checkOnce = 0;

  void initailizeWebsocket() async {
    channel = WebSocketChannel.connect(
        Uri.parse('ws://209.38.239.190:3005?phone=${HelperVariables.Phone}'));

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
        .get(Uri.parse('http://209.38.239.190/deleteFromIds?phone=$phone'));
    print(response.body);
  }

  Future<void> closeSocket(int phone) async {
    var response = await http
        .get(Uri.parse('http://209.38.239.190/closeTheConnection?phone=$phone'));
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

  void getDataOfOtherUser() async {
    var response = await http.get(
        Uri.parse('http://209.38.239.47/users/user?phone=${widget.phone}'));
    var data = jsonDecode(response.body);
    print(data);
    if (!mounted) return;
    setState(() {
      Othername = data[0]['name'];
      image = data[0]['image'];
    });
    print(Othername);
    print(image);
  }

  void controllerInitializer() async {
    googleMapController = await _mapController.future;
    print("Enterd ");
  }

  var load = false;

  @override
  void initState() {
    controllerInitializer();
    // print('1 ${HelperVariables.pilotcurrentLocation}');
    //
    // setState(() {
    passengerCurrentLocation = HelperVariables.passengercurrentLocation;
    // });
    print("2");
    initailizeWebsocket();
    print("3");
    Future.delayed(Duration(seconds: 2), () {
      getlocations();
    });

    Future.delayed(Duration(seconds: 2), () {
      getDataOfOtherUser();
    });
    deleteFromIds(int.parse(HelperVariables.Phone));

    // getDataOfOtherUser();

    // TODO: implement initState
    super.initState();
  }

  double starRating = 2, experienceRating = 3;

  final _controller = TextEditingController();

  String customFeedback = "";

  var data = [30.8, 78.3];
  var dialogContexts;
  int x = 0;

  void validateInput(BuildContext context) async {
    print(x);
    var _apiResponse = await OtpMethods().validateOtp(
        otp:x,
        pilot: widget.phone!,
        passenger: int.parse(HelperVariables.Phone));
    if (_apiResponse.body == "true") {
      // Navigator.pop(this.context);
      channel!.sink.add(jsonEncode({'to': widget.phone, 'location': 'end'}));
      OtpMethods().deleteOtp(otp: x, pilot: widget.phone!, passenger: int.parse(HelperVariables.Phone));
      Future.delayed(Duration(seconds: 1), () {
  _FeedbackDialog();
        // Navigator.pushNamedAndRemoveUntil(
        //     context, Options.id,(route)=>false);
      });
    } else if (_apiResponse.body == "false") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Wrong Otp"),
        duration: Duration(milliseconds: 2000),
      ));
    }
  }
  var money = 0;


  Future<void> _FeedbackDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: const Text(
                "How was your latest ride?",
                style: TextStyle(fontFamily: 'Nunito Sans'),
              ),
              titlePadding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 2,
                  left: SizeConfig.safeBlockVertical * 2,
                  bottom: SizeConfig.safeBlockVertical),
              actions: <Widget>[
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical,
                      vertical: SizeConfig.safeBlockVertical),
                  child: Center(
                    child: Text(
                      "Rate your Co-rider",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.5),
                    ),
                  ),
                ),
                Center(
                    child: SmoothStarRating(
                      size: 35,
                      color: Colors.amber,
                      allowHalfRating: true,
                      borderColor: Colors.grey,
                      defaultIconData: Icons.directions_bike,
                      halfFilledIconData: Icons.directions_bike,
                      filledIconData: Icons.directions_bike,
                      spacing: 10,
                      rating: starRating,
                      onRatingChanged: (rating) {
                        starRating = rating;
                        print(starRating);
                        setState(() {});
                      },
                    )),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Riding experience",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.5),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: RatingBar.builder(
                          glow: false,
                          unratedColor: Colors.grey,
                          initialRating: 3,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                );
                              case 1:
                                return Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 2:
                                return Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 3:
                                return Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 4:
                                return Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                              default:
                                return Icon(Icons.close);
                            }
                          },
                          onRatingUpdate: (rating) {
                            experienceRating = rating;
                            // print("Experience Rating is: $experienceRating");
                          },
                        ))),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                // Visibility(
                //   visible: true ,
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: SizeConfig.safeBlockVertical * 2,
                //         vertical: SizeConfig.safeBlockVertical * 2),
                //     child: Align(
                //       alignment:
                //       Alignment(0, SizeConfig.safeBlockVertical * -0.09),
                //       child: Material(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.circular(10),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Text(
                //                 "Did the passenger pay you the amount?",
                //                 style: TextStyle(
                //                     color: Colors.grey,
                //                     fontWeight: FontWeight.w600,
                //                     fontFamily: 'Nunito Sans',
                //                     fontSize: 16.5),
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   ElevatedButton(
                //                       style: ButtonStyle(
                //                           backgroundColor:
                //                           MaterialStateProperty.all(
                //                               Colors.black)),
                //                       onPressed: () {},
                //                       child: Text(
                //                         'NO',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.w600,
                //                             fontFamily: 'Nunito Sans',
                //                             fontSize: 14),
                //                       )),
                //                   ElevatedButton(
                //                       style: ButtonStyle(
                //                           backgroundColor:
                //                           MaterialStateProperty.all(
                //                               Colors.black)),
                //                       onPressed: () {},
                //                       child: Text(
                //                         'Yes',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.w600,
                //                             fontFamily: 'Nunito Sans',
                //                             fontSize: 14),
                //                       )),
                //                 ],
                //               )
                //             ],
                //           )),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical * 2,
                      vertical: SizeConfig.safeBlockVertical * 2),
                  child: Align(
                    alignment: Alignment(0, SizeConfig.safeBlockVertical * -0.09),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        controller: _controller,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Write your feedback...",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Nunito Sans',
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical * 2,
                      vertical: SizeConfig.safeBlockVertical * 1),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        customFeedback = _controller.text;
                        // print("Star Rating is: $starRating");
                        // print("Experience Rating is: $experienceRating");
                        // print("Custom Feedback is: $customFeedback");
                        CrossFeedbackDialog().postFeedback();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Feedback Submitted"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.of(context)
                            .pushReplacementNamed(firstpage.id);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text("Submit"),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
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
            backgroundColor: Color.fromARGB(255, 227, 227, 227),
            content: SingleChildScrollView(
              child: ListBody(

                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                               color: Colors.transparent,
                          child: Text(
                              'Your ride is completed! \n\n'
                                  'Please pay $money to the Pilot by any method you would like to pay\n\n'
                                 'After completing the payment, please enter the OTP shared by Pilot to complete the ride',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'NunitoSans',
                              color: Color.fromRGBO(30, 60, 87, 1),
                              fontWeight: FontWeight.w600
                          ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 9,
                          width: SizeConfig.safeBlockHorizontal * 87,
                          child: Pinput(
                            onChanged: (val) {
                              x = int.parse(val);
                            },
                            length: 4,
                            // controller: otpController,
                            defaultPinTheme: PinTheme(
                              width: SizeConfig.safeBlockHorizontal * 15,
                              height: SizeConfig.safeBlockVertical * 7,
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'NunitoSans',
                                  color: Color.fromRGBO(30, 60, 87, 1),
                                  fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.059),
                                    offset: Offset(0, 3),
                                    blurRadius: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.safeBlockVertical * 1),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                validateInput(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: const Text(
                                "End your ride!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'NunitoSans',
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
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
                    child: Text('Sorry,your pilot has canceled the ride!',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito Sans',
                        fontSize: 16.5
                    ),
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
                      channel!.sink.add(jsonEncode(
                          {'to': widget.phone, 'location': "cancel"}));
                      Navigator.of(context)
                          .pushReplacementNamed(firstpage.id);
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
var checkEnd=0;
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
                            print(snapshot.data.runtimeType);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (!mounted) return;
                              setState(() {
                                val = jsonDecode(snapshot.data);
                                if (val == 'started') {
                                  rideStarted = true;
                                  showOTP = false;
                                  getPolyPoint(
                                      passengerCurrentLocation!.latitude!,
                                      passengerCurrentLocation!.longitude!,
                                      PassengerScreen.des.latitude,
                                      PassengerScreen.des.longitude);
                                } else if (val == 'cancel' && checkOnce ==0) {
                                    _showMyDialog();
                                    Future.delayed(Duration(seconds: 2),()
                                    {
                                      Navigator.of(context)
                                          .pushReplacementNamed(firstpage.id);
                                    });
                                  channel!.sink.close();
                                  checkOnce=1;
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
                            )),
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
                                        image: NetworkImage('$image'),
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
                                    child: Padding(
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
                              SizedBox(
                                width: 25,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _Cancel();
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
                  Visibility(
                    visible: showOTP,
                    child: Center(
                      child: PassengerPopupDialog(
                        passenger: int.parse(HelperVariables.Phone),
                        pilot: widget.phone!,
                      ),
                    ),
                  )
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
