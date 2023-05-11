import 'dart:math';
import 'api_otp_methods.dart';
// import 'internet_connect.dart';
import 'package:veloce/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PassengerPopupDialog extends StatefulWidget {
  static var id = 'PassengerPopupDialog';
  final int passenger;
  final int pilot;
  const PassengerPopupDialog({required this.passenger,required this.pilot});
  @override
  State<PassengerPopupDialog> createState() => _PassengerPopupDialogState();
}

class _PassengerPopupDialogState extends State<PassengerPopupDialog> {
  bool _isLoading = true;
  bool _internetStat = true;
  List<int> otp = [
    Random().nextInt(9),
    Random().nextInt(9),
    Random().nextInt(9),
    Random().nextInt(9)
  ];

  void postFunc() async {
    // _internetStat = await isInternet();
    // if (_internetStat == false) {
    //   setState(() {
    //     _internetStat = false;
    //   });
    //   return;
    // }
    // print(_internetStat);
    var _apiResponse = await OtpMethods().postOtp(pilot:widget.pilot,passenger:widget.passenger ,otp: int.parse(otp.join('')));
    if (_apiResponse == 200) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    print("I was called");
    postFunc();
// TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      title: const Text(
        "Please share this otp with Pilot",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: 'NunitoSans',
            fontSize: 20),
      ),
      insetPadding: EdgeInsets.all(SizeConfig.safeBlockVertical * 3),
      titlePadding: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * 3,
          left: SizeConfig.safeBlockVertical * 2,
          bottom: SizeConfig.safeBlockVertical),
      actions: <Widget>[
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
    );
  }
}
