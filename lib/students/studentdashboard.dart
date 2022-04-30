import 'package:flutter/material.dart';
import 'package:reliable_app/logoutscreen.dart';
import 'package:reliable_app/students/studentabout.dart';
import 'package:reliable_app/students/studentdailyattendance.dart';
import 'package:reliable_app/students/studentfeedback.dart';
import 'package:reliable_app/students/studentprofileinformation.dart';

class StudentDashboard extends StatefulWidget {
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

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentAbout()));
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

                      child: InkWell( onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentProfileInformation()) );
                      },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/icons/userprofile.png', height: 80),
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
                    InkWell( onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDailyAttendance()) );
                    },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/timetable.png', height: 80),
                            SizedBox(height: 10),
                            Text(
                              'Daily Attendance',
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StudentFeedback()) );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/icons/query.png', height: 80),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'FeedBack',
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell( onTap: (){
                      showDialog(context: context, builder: (context)=> LogoutScreen());
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
