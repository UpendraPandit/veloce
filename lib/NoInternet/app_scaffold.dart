import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veloce/Screens/splashscreen.dart';
import 'package:veloce/Service/network_service.dart';

class AppScaffold extends StatefulWidget {
  static var id = "AppScaffold";

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  var networkStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void checkForRedirection() {
    print("Entered");
    // if (networkStatus == NetworkStatus.online) {
    //   //Navigator.pushNamed(context, SplashScreen.id);
    // }
  }

  // final Widget child;
  @override
  Widget build(BuildContext context) {
    networkStatus = Provider.of<NetworkStatus>(context);
    checkForRedirection();
    print("NetworkStatus:$networkStatus");
    if (networkStatus == NetworkStatus.offline) {
      return noInternetScaff();
    } else
      return SplashScreen();
  }
}

Widget noInternetScaff() {
  return SafeArea(
    child: Scaffold(
      body: Container(
          //child: Image.asset('assets/noint.jpg'),
          child: Center(
              child: Text(
        "No Internet",
        style: TextStyle(fontFamily: 'RubikMono', fontSize: 25),
      ))),
    ),
  );
}
