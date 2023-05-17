import 'package:veloce/Helper/HelperVariables.dart';

import '/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrossFeedbackDialog  {
  void postFeedback({int?phone,String? other,String?role, String? starRating, String? experienceRating, String? customFeedback,String? destination}) async {
    var response = await http.post(
      Uri.parse("http://209.38.239.190/feedback/crossFeedback"),
      body: jsonEncode({
        "cross_feedback": {
          "phone": phone,
          // HelperVariables.Phone, //variable needed
          "with": other,
          "destination":destination,
          "riderStatus": role,
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


}
