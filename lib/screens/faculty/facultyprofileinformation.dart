import 'package:flutter/material.dart';

class FacultyProfileInformation extends StatefulWidget {
  static const String routeName = "/FacultyProfileInformation";

  const FacultyProfileInformation({Key? key}) : super(key: key);

  @override
  _FacultyProfileInformationState createState() => _FacultyProfileInformationState();
}

class _FacultyProfileInformationState extends State<FacultyProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Faculty Profile Information Page'),
            ),
          )
      ),
    );
  }
}
