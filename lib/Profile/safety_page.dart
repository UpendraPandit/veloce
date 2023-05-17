import 'package:flutter/material.dart';

import '../sizeConfig.dart';
import 'profile.dart';
import 'profile_second.dart';

class safety_protocol_page extends StatelessWidget {
  const safety_protocol_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context,
                        SlideRightPageRoute(page: TwoWidget(),
                    )
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 35,
                  ),
                );
              }
            ),
            Text(
              'Safety Protocol',
              style: TextStyle(fontFamily: 'Nunito Sans'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(2),
        child: Container(
            height: SizeConfig.blockSizeVertical * 100,
            width: SizeConfig.blockSizeHorizontal * 100,
            color: Colors.transparent,
            child: ListView(
              children: <Widget>[
                Divider(
                  color: Color.fromARGB(255, 230, 230, 230), // Customize the color of the line
                  thickness: 1.0, // Adjust the thickness of the line
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: ListTile(
                    title: Text(
                      'Safety Protocol for Pilots',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical*2,
                      ),
                  child: ListTile(
                    title: Text(
                      '1. Verification and Background Checks:',
                      style: TextStyle(
                        fontSize: 18,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Pilots are required to undergo a thorough verification process, including background checks, before being approved as a rider.',
                      style: TextStyle(
                        fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '2. Trip Confirmation:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots must confirm trip details before commencing a ride to ensure accuracy and alignment with the passenger\'s request.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '3. Communication Guidelines:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots should utilize the in-app messaging system for communication with passengers, ensuring clear and effective communication.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
                  child: ListTile(
                    title: Text(
                      '4. Safety Ratings and Feedback:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'After each ride, pilots have the opportunity to rate and provide feedback on the passenger\'s behavior and adherence to safety protocols.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '5. Sharing Petrol Expenses:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots are encouraged to participate in the sharing of petrol expenses with passengers to promote fairness and cost-sharing.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '6. Traffic Rules and Safe Driving:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots must follow all traffic rules and regulations while driving, ensuring the safety of both themselves and the passengers.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '7. No Alcohol or Drug Consumption:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots must strictly refrain from consuming alcohol or drugs before or during a trip to ensure clear judgment and safe driving.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '8. Vehicle Maintenance and Safety:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots should ensure their vehicle is well-maintained and in good working condition, regularly checking for any potential safety issues.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '9. Emergency Preparedness:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Pilots should keep emergency contact numbers readily available in case of any unforeseen circumstances or emergencies.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 230, 230, 230), // Customize the color of the line
                  thickness: 1.0, // Adjust the thickness of the line
                ),
                Padding(padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical*10)),
                Divider(
                  color: Color.fromARGB(255, 230, 230, 230), // Customize the color of the line
                  thickness: 1.0, // Adjust the thickness of the line
                ),
                Padding(
                  padding: EdgeInsets.only(
                    // top: SizeConfig.blockSizeVertical,
                  ),
                  child: ListTile(
                    title: Text(
                      'Safety Protocol for Passengers',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical*1)),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '1. Verification and Background Checks:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Passengers are required to undergo a thorough verification process, including background checks, to ensure the safety of the pilots.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '2. Trip Confirmation:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Passengers should confirm trip details before commencing the ride to ensure accuracy and avoid any misunderstandings.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical,
                  ),
                  child: ListTile(
                    title: Text(
                      '3. Communication Guidelines:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Passengers should utilize the in-app messaging system to communicate with pilots, ensuring clear and effective communication.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '4. Safety Ratings and Feedback:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Passengers should provide ratings and feedback on each ride, allowing pilots to improve their services and maintain safety standards.',
                      style: TextStyle(
                        fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '5. Sharing Petrol Expenses:',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Passengers are encouraged to participate in sharing petrol expenses with pilots to promote fairness and cost-sharing.',
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '6. Traffic Rules and Safety:',
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Passengers should observe and follow all traffic rules and regulations during the ride, contributing to a safe and responsible journey.',
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListTile(
                    title: Text(
                      '7. No Alcohol or Drug Consumption:',
                      style: TextStyle(fontSize:18,fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Passengers must refrain from consuming alcohol or drugs during the ride to ensure a safe and comfortable environment.',
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    '8. Personal Safety Awareness:',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Passengers should remain vigilant and exercise personal safety measures, such as wearing seat belts and being aware of their surroundings.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 230, 230, 230), // Customize the color of the line
                  thickness: 1.0, // Adjust the thickness of the line
                ),
              ],
            )),
      ),
    );
  }
}
