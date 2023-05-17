import 'package:flutter/material.dart';

import 'package:veloce/sizeConfig.dart';
import 'package:location/location.dart';

class FirstScreen extends StatefulWidget {
  final screenName;
  const FirstScreen({required this.screenName});
  static double? latitude = 0.0;
  static double? longitude = 0.0;
  static String lat = '0.0';
  static String long = '0.0';

  static var id = 'FirstScreen';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

Map<String, dynamic> ck = {
  'hello': 1,
};

class _FirstScreenState extends State<FirstScreen> {
  void getLocation() async {
    Location location = Location();
    print('error1');
    bool serviceEnabled;

    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    print("locationStatus: $serviceEnabled");
    while (!serviceEnabled) {
      print("ServiceStatus: $serviceEnabled");
      serviceEnabled = await location.requestService();
    }
    // if (!serviceEnabled) {
    //return;
    //}
    //}

    //await Future.delayed(const Duration(seconds: 2), () {});

    // while (
    //     !serviceEnabled); //so that permission dialog not get popped up before service request.

    permissionGranted = await location.hasPermission();
    print("permissionStatus1: $permissionGranted");

    while (permissionGranted == PermissionStatus.denied) //{
        {
      print("permissionStatus2: $permissionGranted");
      permissionGranted = await location.requestPermission();
    }

    print("permissionStatus3: $permissionGranted");
    // while (permissionGranted !=
    //     PermissionStatus.granted); //to avoid going to next screen
    // if (permissionGranted != PermissionStatus.granted) {
    //return;
    // }
    //}

    locationData = await location.getLocation();
    if (!mounted) return;
    setState(() {
      FirstScreen.latitude = locationData.latitude;
      Navigator.pushNamedAndRemoveUntil(
          context, widget.screenName, (Route<dynamic> route) => false);
      print("setted");
    });
    FirstScreen.longitude = locationData.longitude;
    FirstScreen.lat = FirstScreen.latitude.toString();
    FirstScreen.long = FirstScreen.longitude.toString();
  }

  @override
  void initState() {
    getLocation();
    print('error');
    // Future.delayed(const Duration(seconds: 4)).then((value) =>

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 3.5,
            ),
          ),
        ),
      ),
    );
  }
}
