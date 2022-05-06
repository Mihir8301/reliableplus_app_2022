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
        appBar: AppBar( backgroundColor: Colors.blueAccent,
      title: Text("Faculty Profile",),
    ),
      body: SafeArea(
          child: Center(
            child: Column(
                children: [
                  SizedBox(height: 40,),
                  Image.asset(
                    'assets/icons/faculty_student_profile_info_icon.png',
                    height: 140,
                  ),
                  Container(

                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text("Faculty ID: ${adminLoginModel.id}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.white),),



                  Text("Email: ${adminLoginModel.email}",style: TextStyle(fontSize: 18, color: Colors.white),),
                  Text("Name: ${adminLoginModel.name}",style: TextStyle(fontSize: 18, color: Colors.white),),

                        SizedBox(height: 40,),
                  ]
                  )


              ),



           ] ),
          )
      )
    );
  }
}
