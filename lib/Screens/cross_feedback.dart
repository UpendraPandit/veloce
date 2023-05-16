import 'package:veloce/Helper/HelperVariables.dart';

import '/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrossFeedbackDialog extends StatefulWidget {
  static var id = "CrossFeedbackDialog";
  final String? role;
  final String? other;

  CrossFeedbackDialog({this.role, this.other});

  @override
  State<CrossFeedbackDialog> createState() => _CrossFeedbackDialogState();
}

class _CrossFeedbackDialogState extends State<CrossFeedbackDialog> {
  double starRating = 2, experienceRating = 3;

  final _controller = TextEditingController();

  String customFeedback = "";

  postFeedback() async {
    var response = await http.post(
      Uri.parse("http://209.38.239.190/feedback/crossFeedback"),
      body: jsonEncode({
        "cross_feedback": {
          "phone": 7452976914,
          // HelperVariables.Phone, //variable needed
          "with": widget.other,
          "destination": "",
          "riderStatus": widget.role,
          "starRating": starRating.toString(),
          "experienceRating": experienceRating.toString(),
          "customFeedback": customFeedback
        }
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response
        .statusCode); //This thing not getting printed on console. ERROR!!!!!!
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: const Text(
            "How was your latest ride?",
            style: TextStyle(fontFamily: 'Nunito Sans'),
          ),
          titlePadding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 2,
              left: SizeConfig.safeBlockVertical * 2,
              bottom: SizeConfig.safeBlockVertical),
          actions: <Widget>[
            SizedBox(height: SizeConfig.safeBlockVertical*2,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockVertical,
                  vertical: SizeConfig.safeBlockVertical),
              child: Center(
                child: Text("Rate your Co-rider",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito Sans',
                      fontSize: 16.5),),
              ),
            ),
            Center(
                child: SmoothStarRating(
              size: 35,
              color: Colors.amber,
              allowHalfRating: true,
              borderColor: Colors.grey,
              defaultIconData: Icons.directions_bike,
              halfFilledIconData: Icons.directions_bike,
              filledIconData: Icons.directions_bike,
              spacing: 10,
              rating: starRating,
              onRatingChanged: (rating) {
                starRating = rating;
                print(starRating);
                setState(() {});
              },
            )),
            SizedBox(height: SizeConfig.safeBlockVertical*2,),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Text("Riding experience",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito Sans',
                      fontSize: 16.5),),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: RatingBar.builder(
                  glow: false,
                  unratedColor: Colors.grey,
                  initialRating: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return Icon(Icons.close);
                    }
                  },
                  onRatingUpdate: (rating) {
                    experienceRating = rating;
                    // print("Experience Rating is: $experienceRating");
                  },
                ))),
            SizedBox(height: SizeConfig.safeBlockVertical*2,),
            Visibility(
              visible: 'pilot' == 'pilot' ? true : false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockVertical * 2,
                    vertical: SizeConfig.safeBlockVertical * 2),
                child: Align(
                  alignment: Alignment(0, SizeConfig.safeBlockVertical * -0.09),
                  child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Did the passenger pay you the amount?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Nunito Sans',
                                fontSize: 16.5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),
                                  onPressed: () {},
                                  child: Text(
                                    'NO',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 14),
                                  )),
                              ElevatedButton(
                                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),
                                  onPressed: () {}, child: Text('Yes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Nunito Sans',
                                    fontSize: 14),
                              )),
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical*2,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockVertical * 2,
                  vertical: SizeConfig.safeBlockVertical * 2),
              child: Align(
                alignment: Alignment(0, SizeConfig.safeBlockVertical * -0.09),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: _controller,
                    maxLines: 3,
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Write your feedback...",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Nunito Sans',
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical*2,),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockVertical * 2,
                  vertical: SizeConfig.safeBlockVertical * 1),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    customFeedback = _controller.text;
                    // print("Star Rating is: $starRating");
                    // print("Experience Rating is: $experienceRating");
                    // print("Custom Feedback is: $customFeedback");
                    postFeedback();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Feedback Submitted"),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text("Submit"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
