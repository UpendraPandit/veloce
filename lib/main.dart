import 'dart:async';
import 'dart:convert';
import 'package:veloce/passenger_popup.dart';
import 'package:veloce/pilot_popup.dart';

import 'list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:veloce/Authorization/OtpValidate.dart';
import 'package:veloce/Helper/Notify.dart';
import 'package:veloce/Authorization/phoneAuth.dart';
import 'package:veloce/Authorization/registrationScreen.dart';
import 'package:veloce/Authorization/takePicture.dart';
import 'package:veloce/Screens/pilot.dart';
import 'package:veloce/Screens/option.dart';
import 'package:veloce/Screens/pilotripscreen.dart';
import 'package:veloce/notification_page.dart';
import 'package:veloce/Screens/passengertripscreen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Helper/HelperVariables.dart';
import 'Screens/passenger.dart';
import 'package:veloce/Screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
var token;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // mapsImplementation.useAndroidViewSurface = false;
    mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
  }

  await Firebase.initializeApp();
  token = await FirebaseMessaging.instance
      .getToken()
      .then((value) =>value);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print("onMessageOpenedApp:$message");
  //   Navigator.pushNamed(navigatorKey.currentState!.context, NotificationPage.id,
  //       arguments: {"message": json.encode(message.data)});
  // });
  //
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null)
  //   {
  //     Navigator.pushNamed(
  //         navigatorKey.currentState!.context, NotificationPage.id,
  //         arguments: {"message": json.encode(message.data)});
  //   }
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("_firebaseMessagingBackgroundHandler: $message");
// }
// WebSocketChannel? channel;
// StreamController<String> _streamController = StreamController<String>.broadcast();
//
// Stream<String> initailizeWebsocket() {
//   print("Entered tje socekt part!");
//   channel = WebSocketChannel.connect(
//       Uri.parse('ws://139.59.44.53:3005?phone=${HelperVariables.Phone}'));
//   // channel!.sink.add(HelperVariables.pilotcurrentLocation);
//   // channel!.stream.listen((event) {
//   //   passengerCurrentLocation.latitude != jsonDecode(event)[0];
//   //   passengerCurrentLocation.longitude != jsonDecode(event)[1];
//   //   print(jsonDecode(event)[0]);
//   //   print('this is soem ${passengerCurrentLocation.latitude!}');
//   // });
//   // return channel!.stream.map((event) {
//   //   print("Hello");
//   //   print('Printing event' + event);
//   //   return event;
//   // });
//   print("Happening");
//   channel!.stream.listen((event) {
//     print('Printing the event'+event);
//     _streamController.add(event);
//   }, onError: (error) {
//     print('Error occurred: $error');
//     _streamController.addError(error);
//     // try to reconnect and create a new stream
//   }, onDone: () {
//     print('Connection closed: ${channel!.closeCode} ${channel!.closeReason}');
//     _streamController.close();
//     // try to reconnect and create a new stream
//   });
//   return _streamController.stream;
// }

// Stream<String> myClosure() async* {
//   final stream = await initailizeWebsocket();
//   await for (final value in stream) {
//     print("called");
//     yield value;
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // StreamProvider<String>(
        // initialData: 'aba',
        // create:(_)=>initailizeWebsocket(),
        // child:
        //

        GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        SplashScreen.id: (_) =>  SplashScreen(token: token,),
        PhoneAuth.id: (_) => const PhoneAuth(),
        OtpValidation.id: (_) => OtpValidation(token: token,),
        RegisterScreen.id: (_) => const RegisterScreen(),
        ClickPicture.id: (_) =>  ClickPicture(token: token,),
        Options.id: (_) => const Options(),
        PassengerScreen.id: (_) => const PassengerScreen(),
        PilotScreen.id: (_) => const PilotScreen(),
        Notify.id: (_) => const Notify(),
        // NotificationPage.id: (_) => const NotificationPage(),
        PassengerTrip.id: (_) => const PassengerTrip(),
        PilotTrip.id: (_) => const PilotTrip(),
        // List.id: (_) => const List(),
        // PilotPopupDialog.id: (_) => PilotPopupDialog(pilot: 0, passenger:0,),
        // PassengerPopupDialog.id: (_) => PassengerPopupDialog(pilot: 0, passenger: 0,),
      },
      initialRoute: SplashScreen.id,
      // ),
    );
  }
}
