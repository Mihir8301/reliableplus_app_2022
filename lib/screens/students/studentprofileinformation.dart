import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliable_app/controllers/providers/user_provider.dart';
import 'package:reliable_app/models/student_model.dart';

class StudentProfileInformation extends StatefulWidget {
  static const String routeName = "/StudentProfileInformation";

  const StudentProfileInformation({Key? key}) : super(key: key);

  @override
  _StudentProfileInformationState createState() => _StudentProfileInformationState();
}

class _StudentProfileInformationState extends State<StudentProfileInformation> {
  @override
  Widget build(BuildContext context) {
    StudentModel studentModel = Provider.of<UserProvider>(context, listen: true).studentModel ?? StudentModel();

    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Student Profile Information Page:${studentModel.name}'),
            ),
          )
      ),
    );
  }
}
