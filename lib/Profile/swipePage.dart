import 'package:flutter/material.dart';
class message extends StatefulWidget {
  const message({Key? key}) : super(key: key);

  @override
  State<message> createState() => _messageState();
}

class _messageState extends State<message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 230, 230, 230),
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
      ),
    );
  }
}
