import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/sizeConfig.dart';

import '../Screens/option.dart';

class ClickPicture extends StatefulWidget {
  static var id = 'ClickPicture';

  const ClickPicture({Key? key}) : super(key: key);

  @override
  _ClickPictureState createState() => _ClickPictureState();
}

var url = 'http://64.226.69.20/uploads';

class _ClickPictureState extends State<ClickPicture> {
  File? image;

  var redirect = false;

  var url = Uri.parse('http://167.71.238.162/createNewUser');



  Future<int> CreateNewUser(context) async {
    print("entered");
    final body = jsonEncode({
      "phone": HelperVariables.Phone,
      "name": HelperVariables.Name,
      "email": HelperVariables.Email,
      "gender": HelperVariables.gender,
      "image": 'https://nauftimage.sgp1.digitaloceanspaces.com/${HelperVariables.img_url}',
      "activeStatus": 1
    });
    print(body);
    Map<String, String> headers = {'Content-Type': 'application/json'};
    print(HelperVariables.img_url.toString());
    var response = await http.post(url, body: body, headers: headers);
    print("entered");
    if (response.statusCode == 200) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('name', HelperVariables.Name);
      sharedPreferences.setString('email', HelperVariables.Email);
      sharedPreferences.setString('gender', HelperVariables.gender);
      sharedPreferences.setString('image', HelperVariables.img_url.toString());
      Navigator.pushNamed(context, Options.id);
    }
    print(response.body);
    return response.statusCode;
  }

  void upload(context, File imageFile) async {
    const String url = 'http://64.226.69.20/uploads';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(imageFile.path);
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    print(respStr.toString());
    if (res.statusCode == 200) {
      var str = dirname(imageFile.path);
      str = imageFile.path.substring(
        imageFile.path.lastIndexOf('/')+1,
      );
      setState(() {
        print(str);
        HelperVariables.img_url =
            str;
        print(str);
      });
      CreateNewUser(context);
    } else {
      print('Nahi Chalega');
    }
  }

  var opened;

  Future UploadImage(ImageSource source) async {
    // Permission permission;
    //
    // if (Platform.isIOS) {
    //   permission = Permission.photos;
    // } else {
    //   permission = Permission.storage;
    // }
    //
    // PermissionStatus permissionStatus = await permission.status;
    //
    // print(permissionStatus);
    //
    // if (permissionStatus == PermissionStatus.restricted) {
    //
    //
    //   permissionStatus = await permission.status;
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.permanentlyDenied) {
    //   _showOpenAppSettingsDialog(context);
    //
    //   permissionStatus = await permission.status;
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.undetermined) {
    //   permissionStatus = await permission.request();
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.denied) {
    //   if (Platform.isIOS) {
    //     _showOpenAppSettingsDialog(context);
    //   } else {
    //     permissionStatus = await permission.request();
    //   }
    //
    //   if (permissionStatus != PermissionStatus.granted) {
    //     //Only continue if permission granted
    //     return;
    //   }
    // }
    //
    // if (permissionStatus == PermissionStatus.granted) {
    //   print('Permission granted');
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 30);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        opened = true;
        print(this.image);
        resize=5;
        showPicture=true;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  double resize=15;
  bool showPicture=false;

  @override
  void initState() {
    print(showPicture);
    opened = false;
    // TODO: implement initState
    super.initState();
  }

  // void uploadPicture(File? image) async {
  //   Map<String, String> headers = {'Content-Type': 'application/json'};
  //   var url = Uri.parse('http://143.110.182.18/uploads');
  //   final body = jsonEncode({
  //     "image": image!.path,
  //   });
  //   print('yahan tak aagya');
  //   final res = await http.post(url, body: body, headers: headers);
  //   print(res.body);
  // }

  @override
  Widget build(BuildContext context) {
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

    SizeConfig().init(context);

    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: SizeConfig.safeBlockVertical * 100,
        width: SizeConfig.safeBlockHorizontal * 100,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical * 13,
            ),
            const Text('Upload Your Picture!',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito Sans',
                    fontSize: 25)),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2.5,
            ),
            const Material(
              color: Colors.transparent,
              child: Text(
                'Our app uses your image solely for verification purposes and keeps it secure and confidential.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito Sans',
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ),

            Visibility(
              visible: showPicture,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2.5,
                  ),
                  Container(
                    height: SizeConfig.safeBlockVertical *25,
                    width: SizeConfig.safeBlockHorizontal * 50,

                    decoration: BoxDecoration(
                        color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FileImage(image==null?File.fromUri(Uri.parse('')):image!),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * resize,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 7,
              width: SizeConfig.safeBlockHorizontal * 50,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.black,
                child: InkWell(
                  splashColor: Colors.black12,
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    UploadImage(ImageSource.camera);
                  },
                  child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      child: const Center(
                          child: Text(
                        'Camera',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito Sans',
                            fontSize: 14.5,
                            color: Colors.white),
                      ))),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 7,
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 7,
              width: SizeConfig.safeBlockHorizontal * 50,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.black,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    UploadImage(ImageSource.gallery);
                  },
                  splashColor: Colors.black12,
                  child: const Material(
                      color: Colors.transparent,
                      child: Center(
                          child: Text(
                        'Gallery',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito Sans',
                            fontSize: 14.5,
                            color: Colors.white),
                      ))),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 7,
            ),
            Visibility(
              visible: opened,
              child: SizedBox(
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 50,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.black,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      _showMyDialog();

                      upload(context, image!);
                    },
                    splashColor: Colors.black12,
                    child: const Material(
                        color: Colors.transparent,
                        child: Center(
                            child: Text(
                          'Proceed',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Nunito Sans',
                              fontSize: 14.5,
                              color: Colors.white),
                        ))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
