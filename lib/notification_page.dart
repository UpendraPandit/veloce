/*
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  static var id = 'NotificationPage';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String message ="";
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arguments =   ModalRoute.of(context)!.settings.arguments;
    if(arguments!=null){
      Map? pushArguments = arguments as Map;
      setState(() {
        message = pushArguments["message"];
      });
    }
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: Text('Pushed Message : $message'),
          ),
        ));
  }
}
*/
