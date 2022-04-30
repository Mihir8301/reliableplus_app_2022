import 'package:flutter/material.dart';

class StudentAbout extends StatefulWidget {
  static const String routeName = "/StudentAbout";

  const StudentAbout({Key? key}) : super(key: key);

  @override
  _StudentAboutState createState() => _StudentAboutState();
}

class _StudentAboutState extends State<StudentAbout> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Student About Page'),
            ),
          )
      ),
    );
  }
}
