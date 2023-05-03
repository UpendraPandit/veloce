// //
// // import 'package:provider/provider.dart';
// // import 'package:flutter/material.dart';
// //
// // void main() async {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       routes: {
// //         ProviderTest.id: (_) => const ProviderTest(),
// //       },
// //       initialRoute: ProviderTest.id,
// //     );
// //   }
// // }
// //
// // class ProviderTest extends StatefulWidget {
// //   static var id = 'ProviderTest';
// //
// //   const ProviderTest({Key? key}) : super(key: key);
// //
// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _ProviderTestState createState() => _ProviderTestState();
// // }
// //
// // class _ProviderTestState extends State<ProviderTest> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamProvider<MyModel>(
// //         create: (BuildContext context)=>GetModel(),
// //         initialData: MyModel(username:'People'),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           backgroundColor: Colors.lightBlue,
// //           title: const Text('Provider Test'),
// //           centerTitle: true,
// //         ),
// //         body: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Container(
// //               color: Colors.lightBlue,
// //               height: 200,
// //               width: 300,
// //               child: Consumer<MyModel>(
// //                 // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
// //                 builder: (context, MyModel, child) {
// //                   return Center(
// //                     child: Text(
// //                       MyModel.username,
// //                       style: const TextStyle(color: Colors.black, fontSize: 15),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //             Consumer<MyModel>(
// //               // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
// //               builder: (context, MyModel, child) {
// //                 return ElevatedButton(onPressed: (){
// //                   MyModel.doS();
// //                 }, child: const Text('Press me'));
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // // ignore: non_constant_identifier_names
// // Stream<MyModel> GetModel(){
// //
// //   return Stream<MyModel>.periodic(const Duration(seconds: 1),(x)=>MyModel(username:'$x')).take(52);
// // }
// // class MyModel with ChangeNotifier {
// // String username;
// // MyModel({required this.username});
// //
// //  Future<void> doS() async{
// //  await Future.delayed(const Duration(seconds: 2));
// //  username='BharatRide';
// //  }
// // // }
// // // import 'package:provider/provider.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // void main() async {
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       routes: {
// // //         ProviderTest.id: (_) => const ProviderTest(),
// // //       },
// // //       initialRoute: ProviderTest.id,
// // //     );
// // //   }
// // // }
// // //
// // // class ProviderTest extends StatefulWidget {
// // //   static var id = 'ProviderTest';
// // //
// // //   const ProviderTest({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   // ignore: library_private_types_in_public_api
// // //   _ProviderTestState createState() => _ProviderTestState();
// // // }
// // //
// // // class _ProviderTestState extends State<ProviderTest> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return FutureProvider(
// // //         create: (BuildContext context)=>GetModel(),
// // //         initialData: MyModel(username:'People'),
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           backgroundColor: Colors.lightBlue,
// // //           title: const Text('Provider Test'),
// // //           centerTitle: true,
// // //         ),
// // //         body: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           crossAxisAlignment: CrossAxisAlignment.center,
// // //           children: [
// // //             Container(
// // //               color: Colors.lightBlue,
// // //               height: 200,
// // //               width: 300,
// // //               child: Consumer<MyModel>(
// // //                 // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
// // //                 builder: (context, MyModel, child) {
// // //                   return Center(
// // //                     child: Text(
// // //                       MyModel.username,
// // //                       style: const TextStyle(color: Colors.black, fontSize: 15),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //             Consumer<MyModel>(
// // //               // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
// // //               builder: (context, MyModel, child) {
// // //                 return ElevatedButton(onPressed: (){
// // //                   MyModel.doS();
// // //                 }, child: const Text('Press me'));
// // //               },
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // // // ignore: non_constant_identifier_names
// // // Future<MyModel> GetModel()async{
// // //   await Future.delayed(const Duration(seconds: 2));
// // //   return MyModel(username: 'Ride');
// // // }
// // // class MyModel with ChangeNotifier {
// // // String username;
// // // MyModel({required this.username});
// // //
// // //  Future<void> doS() async{
// // //  await Future.delayed(const Duration(seconds: 2));
// // //  username='BharatRide';
// // //  print(username);
// // //  }
// // // }
// // // import 'package:provider/provider.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // //
// // // void main() async {
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       routes: {
// // //         ProviderTest.id: (_) => const ProviderTest(),
// // //       },
// // //       initialRoute: ProviderTest.id,
// // //     );
// // //   }
// // // }
// // //
// // // class ProviderTest extends StatefulWidget {
// // //   static var id = 'ProviderTest';
// // //
// // //   const ProviderTest({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   _ProviderTestState createState() => _ProviderTestState();
// // // }
// // //
// // // class _ProviderTestState extends State<ProviderTest> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return ChangeNotifierProvider(
// // //       create: (BuildContext context) => MyModel(),
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           backgroundColor: Colors.lightBlue,
// // //           title: Text('Provider Test'),
// // //           centerTitle: true,
// // //         ),
// // //         body: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           crossAxisAlignment: CrossAxisAlignment.center,
// // //           children: [
// // //             Container(
// // //               color: Colors.lightBlue,
// // //               height: 200,
// // //               width: 300,
// // //               child: Consumer<MyModel>(
// // //                 builder: (context, MyModel, child) {
// // //                   return Center(
// // //                     child: Text(
// // //                       '${MyModel.a}',
// // //                       style: TextStyle(color: Colors.black, fontSize: 15),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //             Container(
// // //               child: Consumer<MyModel>(
// // //                 builder: (context, MyModel, child) {
// // //                   return ElevatedButton(onPressed: (){
// // //                     MyModel.doS();
// // //                   }, child: Text('Press me'));
// // //                 },
// // //               ),
// // //             )
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class MyModel with ChangeNotifier {
// // //   int a = 1;
// // //
// // //   void doS() {
// // //     a++;
// // //     print(a);
// // //     notifyListeners();
// // //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'websocket_service.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         StreamProvider<String>.value(value: WebSocketService().stream, initialData: 'a',),
//       ],
//       child: MaterialApp(
//         title: 'WebSocket Example',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: HomeScreen(),
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Go to Second Screen'),
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => SecondScreen()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen'),
//       ),
//       body: Center(
//         child: StreamBuilder<String>(
//           stream: context.watch<Stream<String>>(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             }
//             return Text(snapshot.data!);
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:veloce/Screens/pilot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'br_verification',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _aadhaarCard = "";
  String _bikeRc = "";
  String _carRc = "";
  String _drivingLicence = "";

  final TextEditingController _aadhaarCardController = TextEditingController();
  final TextEditingController _bikeRcController = TextEditingController();
  final TextEditingController _carRcController = TextEditingController();
  final TextEditingController _drivingLicenceController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Black Theme UI"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              "Enter Aadhaar Card Number",
              style: TextStyle(fontSize: 16.0),
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PilotScreen()),
                  );

                },
                child: Text('Tap Here'),
            ),
            TextField(
              controller: _aadhaarCardController,
              decoration: InputDecoration(
                hintText: "Aadhaar Card Number",
              ),
              onChanged: (value) {
                setState(() {
                  _aadhaarCard = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              "Enter Bike RC Number",
              style: TextStyle(fontSize: 16.0),
            ),
            TextField(
              controller: _bikeRcController,
              decoration: InputDecoration(
                hintText: "Bike RC Number",
              ),
              onChanged: (value) {
                setState(() {
                  _bikeRc = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Text(
              "Enter Driving Licence Number",
              style: TextStyle(fontSize: 16.0),
            ),
            TextField(
              controller: _drivingLicenceController,
              decoration: InputDecoration(
                hintText: "Driving Licence Number",
              ),
              onChanged: (value) {
                setState(() {
                  _drivingLicence = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}