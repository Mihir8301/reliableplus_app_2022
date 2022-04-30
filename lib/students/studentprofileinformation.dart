import 'package:flutter/material.dart';
class StudentProfileInformation extends StatefulWidget {
  const StudentProfileInformation({Key? key}) : super(key: key);

  @override
  _StudentProfileInformationState createState() => _StudentProfileInformationState();
}

class _StudentProfileInformationState extends State<StudentProfileInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Student Profile Information Page'),
            ),
          )
      ),
    );
  }
}
