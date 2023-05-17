import 'dart:convert';

import 'package:flutter/material.dart';
import '../sizeConfig.dart';
import 'package:http/http.dart' as http;

class ReportIssueForm extends StatefulWidget {
  @override
  _ReportIssueFormState createState() => _ReportIssueFormState();
}

class _ReportIssueFormState extends State<ReportIssueForm> {
  final _formKey = GlobalKey<FormState>();
  String _issueDescription = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Perform the form submission logic here
      submitIssue(_issueDescription);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Issue reported successfully')),
      );

      _formKey.currentState!.reset();
    }
  }

  Future<void> submitIssue(String issueDescription) async {
    var url = Uri.parse('http://139.59.44.53/feedback/crossFeedback');
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        url,
        body: jsonEncode({'issue_description': issueDescription}),
        headers: headers
    );


    if (response.statusCode == 200) {
      // Request successful, do something with the response
      print('Response body: ${response.body}');
    } else {
      // Request failed, handle the error
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text('Describe the issue'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              Text(
                'If you are facing any problem with the app or you have faced any issuse with any ride,\nPlease describe the issue:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the issue description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _issueDescription = value!;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'enter issue here',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: const Color.fromARGB(255, 230, 230, 230),
                  splashFactory: NoSplash.splashFactory,
                  elevation: 0,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'NunitoSans',
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
