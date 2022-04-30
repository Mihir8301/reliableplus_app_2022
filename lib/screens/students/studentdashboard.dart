import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliable_app/controllers/user_controller.dart';

import '../../controllers/providers/user_provider.dart';
import '../common/screens/logoutscreen.dart';
import 'studentabout.dart';
import 'studentdailyattendance.dart';
import 'studentfeedback.dart';
import 'studentprofileinformation.dart';

class StudentDashboard extends StatefulWidget {
  static const String routeName = "/StudentDashboard";

  const StudentDashboard({Key? key}) : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
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
            getHeader(),
            getStudentNameWidget(),
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
                      Navigator.pushNamed(context, StudentProfileInformation.routeName);
                    },
                  ),
                  getButton(
                    text: 'Daily Attendance',
                    iconPath: 'assets/icons/timetable.png',
                    ontap: () {
                      Navigator.pushNamed(context, StudentDailyAttendance.routeName);
                    },
                  ),
                  getButton(
                    text: 'FeedBack',
                    iconPath: 'assets/icons/query.png',
                    ontap: () {
                      Navigator.pushNamed(context, StudentFeedback.routeName);
                    },
                  ),
                  getButton(
                    text: 'LogOut',
                    iconPath: 'assets/icons/logout.png',
                    ontap: () {
                      showDialog(context: context, builder: (context)=> LogoutScreen());
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

  Widget getHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //If Logout then ask first then Navigate
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              showDialog(context: context, builder: (context)=> LogoutScreen());
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

          IconButton(
            icon: Icon(Icons.info),
            color: Colors.white,
            onPressed: () {

              Navigator.pushNamed(context, StudentAbout.routeName);
            },
          ),
        ],
      ),
    );
  }

  Widget getStudentNameWidget() {
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
          Text('${(Provider.of<UserProvider>(context,).studentModel?.name.isNotEmpty ?? false) ? Provider.of<UserProvider>(context,).studentModel!.name : "There!"}',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 25.0))
        ],
      ),
    );
  }


  //Supporting Widgets
  Widget getButton({required String text, required String iconPath, void Function()? ontap}) {
    return InkWell(
      onTap: () {
        if(ontap != null) {
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
    // TODO: implement shouldReclip
    return true;
  }
}
