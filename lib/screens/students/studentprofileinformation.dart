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
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Student Profile",),
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
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            children: [
                              SizedBox(height: 30,),
                              Text("Name: ${studentModel.name} ",style: TextStyle(fontSize: 18,  color: Colors.white),),
                              Text("Branch: ${studentModel.branch}",style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text("Enrollment No: ${studentModel.enrollment_id}", style: TextStyle(fontSize: 18, color: Colors.white),),

                              Text("   Email: ${studentModel.email}",style: TextStyle(fontSize: 18, color: Colors.white),),
                              Text("      Phone No: ${studentModel.phone}",style: TextStyle(fontSize: 18, color: Colors.white),),

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
