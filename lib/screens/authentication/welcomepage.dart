import 'package:flutter/material.dart';

import 'facultyloginpage.dart';
import 'studentloginpage.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = "/WelcomePage";

  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              getHeaderWidget(),
              getImageWidget(),
              getButtonsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeaderWidget() {
    return Column(
      children: <Widget>[
        Text(
          "Welcome To Reliable+",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,

          ),

        ),
        SizedBox(
          height: 20,
        ),
        Text("A smart application you can rely on ",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,

          ),)
      ],
    );
  }

  Widget getImageWidget() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcome.png")
          )
      ),
    );
  }

  Widget getButtonsWidget() {
    return  Column(
      children: <Widget>[
        // the login button
        MaterialButton(
          minWidth: double.infinity,
          height: 60,
          onPressed: () {
            Navigator.pushNamed(context, FacultyLoginPage.routeName);
          },
          // defining the shape
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.black
              ),
              borderRadius: BorderRadius.circular(50)
          ),
          child: Text(
            "Faculty",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
          ),
        ),
        // creating the signup button
        SizedBox(height:20),
        MaterialButton(
          minWidth: double.infinity,
          height: 60,
          onPressed: (){
            Navigator.pushNamed(context, StudentLoginPage.routeName);
          },
          color: Color(0xff448aff),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          child: Text(
            "Student",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18
            ),
          ),
        ),
      ],
    );
  }
}
