
import 'package:flutter/material.dart';
import 'package:veloce/Authorization/phoneAuth.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/Authorization/takePicture.dart';
import '../sizeConfig.dart';
import 'package:email_validator/email_validator.dart';

List<String> genders = ['Select', 'male', 'female'];
String dropdownValue = genders.first;

class RegisterScreen extends StatefulWidget {
  static var id = "RegisterScreen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var name = "";
  var email = "";
  var univ_id = 0;

  Future<void> _DetailsError() async {
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
                    'Please fill the details correctly!',
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
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
            child: Scaffold(
          body: SizedBox(
            height: SizeConfig.safeBlockVertical * 100,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 8,
                  ),
                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Nunito Sans',
                        fontSize: 21),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.75,
                  ),
                  const Text(
                    'Please fill the details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito Sans',
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Nunito Sans',
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6.5,

                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: TextFormField(
                      
                        onChanged: (val) {
                          name = val;
                        },
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito Sans',
                            fontSize: 15),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter your name',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Nunito Sans',
                              fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.75,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.75,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.75,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Email',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Nunito Sans',
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: TextFormField(
                        onChanged: (val) {
                          email = val;
                        },
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito Sans',
                            fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Nunito Sans',
                              fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.75,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.75,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.75,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: SizeConfig.safeBlockVertical * 3.5,
                    width: SizeConfig.safeBlockHorizontal * 70,
                    child: const Text(
                      'Gender',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Nunito Sans',
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 0.5,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 7),
                      height: SizeConfig.safeBlockVertical * 6.5,
                      width: SizeConfig.safeBlockHorizontal * 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(width: 1.75, color: Colors.black)),
                      child: DropdownButton<String>(
                        alignment: Alignment.centerRight,
                        value: dropdownValue,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                            print(dropdownValue);
                          });
                        },
                        items: genders
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 15),
                            ),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.75,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 6,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 7,
                    width: SizeConfig.safeBlockHorizontal * 50,
                    child: InkWell(
                      onTap: () async {
                        bool isValid = EmailValidator.validate(email);

                        if (name.isNotEmpty &&
                            isValid &&
                            dropdownValue != 'Select') {
                          setState(() {
                            HelperVariables.Name = name;
                            HelperVariables.Phone = PhoneAuth.phone;
                            HelperVariables.gender = dropdownValue;
                            HelperVariables.Email = email;
                          });
                          //      _showMyDialog();
                          Navigator.pushNamed(context, ClickPicture.id);
                        } else {
                          _DetailsError();
                          // Navigator.pushNamed(context, SecondScreen.id);
                        }
                      },
                      child: Material(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.black,
                            child: const Center(
                                child: Text(
                              'Register',
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
        )),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
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
        );
      },
    );
  }
}
