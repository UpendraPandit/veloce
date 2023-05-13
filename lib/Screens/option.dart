import 'package:flutter/material.dart';
import 'package:veloce/Screens/first.dart';
import 'package:veloce/Screens/passenger.dart';
import 'package:veloce/Screens/pilot.dart';
import '../sizeConfig.dart';

class Options extends StatefulWidget {
  static var id = 'Options';

  const Options({Key? key}) : super(key: key);

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
          child: Scaffold(
        body: Container(
          color: Colors.white,
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 47.5,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: Image.asset('assets/3.jpg'),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 13.5,
              ),
              Button(
                title: 'Passenger',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(PassengerScreen.id);
                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  //     FirstScreen(screenName: PassengerScreen.id)), (Route<dynamic> route) => false);
                },
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 7.5,
              ),
              Button(
                title: 'Pilot',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(PilotScreen.id);
                  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  //     FirstScreen(screenName:PilotScreen.id)), (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const Button({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.safeBlockVertical * 7,
      width: SizeConfig.safeBlockHorizontal * 50,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.black,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          splashColor: Colors.black12,
          child: Material(
              color: Colors.transparent,
              child: Center(
                  child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Nunito Sans',
                    fontSize: 14.5,
                    color: Colors.white),
              ))),
        ),
      ),
    );
  }
}
