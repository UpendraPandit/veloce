import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veloce/Authorization/phoneAuth.dart';
import 'package:veloce/Screens/option.dart';
import 'dart:convert';
import '../sizeConfig.dart';

class SplashScreen extends StatefulWidget {
  static var id = 'SplashScreen';
  final String? token;

  const SplashScreen({this.token});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidation().whenComplete(() async {
      Timer(
          const Duration(seconds: 2),
          () => Get.to(
              () => finalPhone == null ? const PhoneAuth() : const Options()));
    });

    // TODO: implement initState
    super.initState();
  }

  Map<String, String> header = {
    'Content-Type': 'application/json',
  };
  String? finalPhone;

  Future<bool> getUserData(var phone) async {
    // print("entered");
    var url =
        Uri.parse('http://167.71.238.162/users/user?phone=${int.parse(phone)}');

    http.Response response = await http.get(url, headers: header);
    var data = jsonDecode(response.body);
    // print(data.toString());
    if (data.length == 0 ){
      return false;
    } else if (data[0]['token']!=widget.token){
      return false;
    }
    else
      {
        return true;
      }
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPhone = sharedPreferences.getString('phone');
    // print("entered");
    if (obtainedPhone != null && await getUserData(obtainedPhone)) {
      setState(() {
        // print("Entered validation part");
        finalPhone = obtainedPhone;
      });
      //  getUserData(obtainedPhone);
      HelperVariables.Name = sharedPreferences.getString('name')!;
      HelperVariables.gender = sharedPreferences.getString('gender')!;
      HelperVariables.Email = sharedPreferences.getString('email')!;
      HelperVariables.Phone = sharedPreferences.getString('phone')!;
      HelperVariables.img_url = sharedPreferences.getString('image')!;
    }
    // print("entered");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: SizedBox(
            height: SizeConfig.safeBlockVertical * 35,
            width: SizeConfig.safeBlockHorizontal * 35,
            child: Image.asset('assets/logo.gif')),
      ),
    ));
  }
}
