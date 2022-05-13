import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliable_app/controllers/providers/user_provider.dart';

import '../common/screens/logoutscreen.dart';
import 'facultyabout.dart';
import 'facultyaddstudent.dart';
import 'facultyfeedback.dart';
import 'facultyprofileinformation.dart';
import 'facultyviewlist.dart';

class FacultyDashboard extends StatefulWidget {
  static const String routeName = "/FacultyDashboard";

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
            getAppbarWidget(),
            getUserNameWidget(),
            SizedBox(height: 40.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 200),
              child: GridView.count(
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                primary: false,
                crossAxisCount: 2,
                padding: EdgeInsets.only(right: 10),
                children: <Widget>[
                  getButton(
                    text: 'Profile Information',
                    iconPath: 'assets/icons/userprofile.png',
                    ontap: () {
                      Navigator.pushNamed(
                          context, FacultyProfileInformation.routeName);
                    },
                  ),
                  getButton(
                    text: 'Add Student',
                    iconPath: 'assets/icons/student.png',
                    ontap: () {
                      Navigator.pushNamed(context, FacultyAddStudent.routeName);
                    },
                  ),
                  getButton(
                    text: 'View List',
                    iconPath: 'assets/icons/list.png',
                    ontap: () {
                      Navigator.pushNamed(context, FacultyViewList.routeName);
                    },
                  ),
                  getButton(
                    text: 'LogOut',
                    iconPath: 'assets/icons/logout.png',
                    ontap: () {
                      showDialog(
                          context: context,
                          builder: (context) => LogoutScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppbarWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //If Logout then ask first then Navigate
          IconButton(
            icon: Icon(Icons.arrow_back),
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
            itemBuilder: (BuildContext context) =>
            [
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
    );
  }

  Widget getUserNameWidget() {
    return Padding(
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
          Text('${(Provider
              .of<UserProvider>(context,)
              .adminLoginModel
              ?.name
              .isNotEmpty ?? false) ? Provider
              .of<UserProvider>(context,)
              .adminLoginModel!
              .name : "There!"}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 25.0))
        ],
      ),
    );
  }


  //Supporting Widgets
  Widget getButton(
      {required String text, required String iconPath, void Function()? ontap}) {
    return InkWell(
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 5,
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconPath, height: 80),
            SizedBox(height: 10,),
            Text(
              text,
            )
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
    return true;
  }
}
