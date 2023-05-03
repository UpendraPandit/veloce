import 'package:flutter/material.dart';
import 'package:veloce/Helper/HelperVariables.dart';
import 'package:veloce/sizeConfig.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Notify extends StatefulWidget {
  static var id = 'Notify';

  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  var showRequest = false;
  var stream;

  void initailizeWebsocket() async {
    final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3005/'));
    channel.sink.add("hello frm flutter");
    channel.stream.listen((event) {
      print(event);
      print(event.runtimeType);
    });
    print("exitted websocekt method ");
  }



  @override
  void initState() {
    initailizeWebsocket();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Container(
            //   height: SizeConfig.safeBlockVertical*80,
            //   width: SizeConfig.safeBlockHorizontal*100,
            //   color: Colors.blue,
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              child: StreamBuilder(
                stream: stream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.runtimeType);
                    if (snapshot.data == HelperVariables.Phone) {
                      showRequest = true;
                    }
                  }
                  print(snapshot.data);
                  return Visibility(
                    visible: showRequest,
                    child: Container(
                      height: SizeConfig.safeBlockVertical * 20,
                      width: SizeConfig.safeBlockHorizontal * 100,
                      color: Colors.green,
                      child: Center(
                        child: Text(
                          snapshot.hasData
                              ? 'Upendra Ne bulayaa hai'
                              : 'Kuch nahi aaya',
                          style:const  TextStyle(
                              fontSize: 20,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
