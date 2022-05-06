import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliable_app/models/admin_login_model.dart';

import '../../controllers/providers/user_provider.dart';

class FacultyProfileInformation extends StatefulWidget {
  static const String routeName = "/FacultyProfileInformation";

  const FacultyProfileInformation({Key? key}) : super(key: key);

  @override
  _FacultyProfileInformationState createState() => _FacultyProfileInformationState();
}

class _FacultyProfileInformationState extends State<FacultyProfileInformation> {
  @override
  Widget build(BuildContext context) {
    AdminLoginModel adminLoginModel = Provider.of<UserProvider>(context, listen: true).adminLoginModel ?? AdminLoginModel();

    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Faculty Profile Information Page:${adminLoginModel.name}'),
            ),
          )
      ),
    );
  }
}
