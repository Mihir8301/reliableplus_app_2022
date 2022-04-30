import 'package:flutter/material.dart';
class FacultyAbout extends StatefulWidget {
  static const String routeName = "/FacultyAbout";

  const FacultyAbout({Key? key}) : super(key: key);

  @override
  _FacultyAboutState createState() => _FacultyAboutState();
}

class _FacultyAboutState extends State<FacultyAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Faculty About Page'),
            ),
          )
      ),
    );
  }
}
