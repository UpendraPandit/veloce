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

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    if(!mounted)return;
  setState(() {
    FirstScreen.latitude = locationData.latitude;
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
    Future.delayed(const Duration(seconds:4)).then((value) => Navigator.pushNamedAndRemoveUntil(context,widget.screenName,(Route<dynamic> route) => false));
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
            child: CircularProgressIndicator(color: Colors.black,strokeWidth: 3.5,),
          ),
        ),
      ),
    );
  }
}
