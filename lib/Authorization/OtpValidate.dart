import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pinput/src/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/Authorization/phoneAuth.dart';
import 'package:veloce/Authorization/registrationScreen.dart';
import '../Screens/option.dart';
import '../sizeConfig.dart';

class OtpValidation extends StatefulWidget {
  static var id = 'OtpValidation';
  final String? token;

  const OtpValidation({this.token});

  @override
  _OtpValidationState createState() => _OtpValidationState();
}

TextEditingController _controller = TextEditingController();
var phone = "";

class _OtpValidationState extends State<OtpValidation> {
  @override
  void initState() {
    _controller.text = "+91";
    // TODO: implement initState
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  var dialogcontext;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        dialogcontext = context;
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
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

  Future<void> _OTPError() async {
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
                    'Please enter the correct OTP!',
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
                Navigator.pop(dialogcontext);
                Navigator.of(context).pop();
                setState(() {
                  absorbpointer = false;
                });
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

  bool absorbpointer = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );
  final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          absorbpointer = false;
        });
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: AbsorbPointer(
            absorbing: absorbpointer,
            child: Scaffold(
              body: Container(
                height: SizeConfig.safeBlockVertical * 100,
                width: SizeConfig.safeBlockHorizontal * 100,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical * 10),
                        height: SizeConfig.safeBlockVertical * 18,
                        width: SizeConfig.safeBlockHorizontal * 48,
                        // color: Colors.greenAccent,
                        child: Image.asset('assets/logo1.png'),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 11,
                      ),
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito Sans',
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
                      ),
                      const Text(
                        'Enter the received OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito Sans',
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 1,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 9,
                        width: SizeConfig.safeBlockHorizontal * 87,
                        // color: Colors.black,
                        child: Pinput(
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          length: 6,
                          // defaultPinTheme: defaultPinTheme,
                          // focusedPinTheme: focusedPinTheme,
                          // submittedPinTheme: submittedPinTheme,
                          showCursor: true,
                          onChanged: (val) {
                            code = val;
                          },
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 7,
                        width: SizeConfig.safeBlockHorizontal * 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.black,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: Colors.black45,
                                onTap: () async {
                                  _showMyDialog();
                                  setState(() {
                                    absorbpointer = true;
                                  });
                                  try {
                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                            verificationId: PhoneAuth.verify,
                                            smsCode: code);

                                    // Sign the user in (or link) with the credential
                                    await auth.signInWithCredential(credential);
                                    HelperVariables.Phone = PhoneAuth.phone;

                                    final SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString(
                                        'phone', HelperVariables.Phone);

                                    await checkFirstTimeUser()
                                        ? Get.to(() => const RegisterScreen())
                                        : Get.to(() => const Options());
                                    print(HelperVariables.Phone);
                                    print("not transferred");
                                    // Navigator.pushNamed(
                                    //     context, RegisterScreen.id);
                                  } catch (e) {
                                    _OTPError();
                                  }
                                },
                                child: const Center(
                                    child: Text(
                                  'Verify',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 14.5,
                                      color: Colors.white),
                                ))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  void changeToken() {
    print("Chanfed toke");
    var res = http.get(Uri.parse(
        'http://209.38.239.47/users/updateToken?phone=${int.parse(PhoneAuth.phone.toString())}&token=${widget.token}'));
    print("Chanfed toke");
  }

  Future<bool> checkFirstTimeUser() async {
    print("entered");
    var url = Uri.parse(
        'http://209.38.239.47/users/user?phone=${int.parse(PhoneAuth.phone.toString())}');
    print(PhoneAuth.phone);
    http.Response response = await http.get(url, headers: header);
    var data = jsonDecode(response.body);
    print(response.body);
    print(data.length);
    if (data.length == 0) {
      return true;
    } else {
      changeToken();
      setState(() {
        HelperVariables.Name = data[0]['name'];
        HelperVariables.gender = data[0]['gender'];
        HelperVariables.Email = data[0]['email'];
        HelperVariables.img_url = data[0]['image'];
      });
      print("Changed");
      return false;
    }
  }
}
