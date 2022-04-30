import 'package:flutter/material.dart';
import 'package:reliable_app/faculty/facultyabout.dart';
import 'package:reliable_app/faculty/facultyaddstudent.dart';
import 'package:reliable_app/faculty/facultyfeedback.dart';
import 'package:reliable_app/faculty/facultyprofileinformation.dart';
import 'package:reliable_app/faculty/facultyviewlist.dart';

import '../logoutscreen.dart';

class FacultyDashboard extends StatefulWidget {
  @override
  _FacultyDashboardState createState() => _FacultyDashboardState();
}

enum _MenuValues { About, Query }

class _FacultyDashboardState extends State<FacultyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 270,
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //If Logout then ask first then Navigate
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => LogoutScreen());
                    },
                  ),
                  Expanded(
                    child: Text('Dashboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold, // -> Roboto-Light.ttf
                            // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                            fontSize: 22.0,
                            color: Colors.white)),
                  ),

                  PopupMenuButton<_MenuValues>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.info_outline_rounded),
                            SizedBox(
                              width: 5,
                            ),
                            Text('About'),
                          ],
                        ),
                        value: _MenuValues.About,
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.question_answer_outlined),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Check Feedback'),
                          ],
                        ),
                        value: _MenuValues.Query,
                      )
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case _MenuValues.About:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FacultyAbout()));
                          break;
                        case _MenuValues.Query:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FacultyFeedback()));
                          break;
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 100),
              child: Row(
                children: <Widget>[
                  Text('Hello',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0)),
                  SizedBox(width: 10.0),
                  Text('There!',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 25.0))
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 200),
              child: Expanded(
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  padding: EdgeInsets.only(right: 10),
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FacultyProfileInformation()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/icons/userprofile.png',
                                  height: 80),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Profile Information',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FacultyAddStudent()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/student.png', height: 90),
                            // SizedBox(height: 2),
                            Text(
                              'Add Student',
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FacultyViewList()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/list.png', height: 80),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'View List',
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => LogoutScreen());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/logout.png', height: 80),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'LogOut',
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 70);
    var controlpoint = Offset(50, size.height);
    var endpoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controlpoint.dx, controlpoint.dy, endpoint.dx, endpoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
