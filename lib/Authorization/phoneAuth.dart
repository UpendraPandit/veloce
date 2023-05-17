import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:veloce/Authorization/OtpValidate.dart';
import 'package:veloce/NoInternet/app_scaffold.dart';
import 'package:veloce/Service/network_service.dart';
import '../sizeConfig.dart';
import 'package:http/http.dart' as http;

class PhoneAuth extends StatefulWidget {
  static var id = 'PhoneAuth';
  static var phone = "";

  const PhoneAuth({Key? key}) : super(key: key);

  static String verify = "";

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

TextEditingController _controller = TextEditingController();

int i = 0;

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  void initState() {
    _controller.text = "+91";
    // TODO: implement initState
    super.initState();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext contexts) {
        contexts;
        return WillPopScope(
          onWillPop: ()async=>false,
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

  Future<void> _NumberError() async {
    BuildContext dialogContext;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // use// r must tap button!

      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          content: Container(
              color: Colors.white,
              height: SizeConfig.safeBlockVertical * 12,
              width: SizeConfig.safeBlockHorizontal * 50,
              child: const Material(
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    'Please enter the correct number of digits!',
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
                Navigator.pop(dialogContext);

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

  Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  Future<bool> checkForDuplicateUser() async {
    print("entered");
    var url = Uri.parse(
        'http://209.38.239.47/users/user?phone=${int.parse(PhoneAuth.phone.toString())}');
    print(PhoneAuth.phone);
    http.Response response = await http.get(url, headers: header);
    var data = jsonDecode(response.body);
    print(response.body);
    if (data.length != 0 && data[0]['activeStatus'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _UsedNumberError() async {
    BuildContext dialogContext;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext contexts) {
        dialogContext = contexts;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          content: Container(
            color: Colors.white,
            height: SizeConfig.safeBlockVertical * 12,
            width: SizeConfig.safeBlockHorizontal * 50,
            child: const Material(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'The number is already in use! Please use new or Login!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito Sans',
                      fontSize: 17.5),
                ),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(dialogContext);
                Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    var maskFormatter = MaskTextInputFormatter(
        mask: ' ### ### ####', filter: {"#": RegExp(r'[0-9]')});

    bool checkAbsorb = false;
    var networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.offline) {
      return noInternetScaff();
    } else
      return WillPopScope(
     onWillPop: ()async=>false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: AbsorbPointer(
            absorbing: checkAbsorb,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: SizeConfig.safeBlockVertical * 100,
                  width: SizeConfig.safeBlockHorizontal * 100,
                  color: Colors.white,
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
                        'Mobile Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito Sans',
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 80,
                        child: const Material(
                          color: Colors.transparent,
                          child: Text(
                            'You will a receive a 6 digit one time password on this mobile number.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito Sans',
                                fontSize: 15,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
                      ),
                      const Text(
                        'Enter your phone number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito Sans',
                            fontSize: 15,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 0,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 7.5,
                        width: SizeConfig.safeBlockHorizontal * 55,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9,-]')),
                            LengthLimitingTextInputFormatter(10),
                            maskFormatter
                          ],
                          decoration: const InputDecoration(
                              prefix: Text(
                            '+91',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Nunito Sans',
                                fontSize: 14.5,
                                color: Colors.black),
                          )),
                          style: const TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Nunito Sans',
                              fontSize: 14.5,
                              color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              PhoneAuth.phone = value;
                            });
                          },
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
                      ),
                      Material(
                        child: InkWell(
                          onTap: () async {

                            var temp = PhoneAuth.phone;
                            setState(() {
                              PhoneAuth.phone = "";
                            });

                            for (int i = 0; i < temp.length; i++) {
                              if (temp[i] == ' ') {
                                continue;
                              }
                              setState(() {
                                PhoneAuth.phone = PhoneAuth.phone + temp[i];
                              });
                            }

                            print(PhoneAuth.phone);
                            // bool val = await checkForDuplicateUser();
                            print("Hello I have entered here!");
                            if (PhoneAuth.phone.length == 10) {
                              _showMyDialog();
                                setState(() {
                                  checkAbsorb = true;
                                  //  _showMyDialog();
                                });
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: _controller.text + PhoneAuth.phone,
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) {
                                      print("Here I have entered!");
                                             print(credential.smsCode);
                                      },
                                  verificationFailed:
                                      (FirebaseAuthException e) {

                                      },
                                  codeSent:
                                      (String verificationId, int? resendToken) {
                                    PhoneAuth.verify = verificationId;
                                    Navigator.pushNamed(
                                        context, OtpValidation.id);
                                  },
                                  codeAutoRetrievalTimeout:
                                      (String verificationId) {},
                                );
                              }
                            else
                              {
                                _NumberError();
                              }


                          },
                          child: SizedBox(
                            height: SizeConfig.safeBlockVertical * 7,
                            width: SizeConfig.safeBlockHorizontal * 55,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: Colors.black,
                                child: const Center(
                                    child: Text(
                                  'Send OTP',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 14.5,
                                      color: Colors.white),
                                ))),
                          ),
                        ),
                      )
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
}
