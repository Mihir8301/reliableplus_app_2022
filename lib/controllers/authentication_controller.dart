import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reliable_app/controllers/navigation_controller.dart';
import 'package:reliable_app/controllers/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:reliable_app/models/admin_login_model.dart';
import 'package:reliable_app/models/student_model.dart';
import 'package:reliable_app/screens/authentication/welcomepage.dart';
import 'package:reliable_app/utils/snakbar.dart';

import '../configs/constants.dart';
import '../utils/my_print.dart';

//To Perform Authentication Operations
class AuthenticationController {
  static AuthenticationController? _instance;

  factory AuthenticationController() {
    _instance ??= AuthenticationController._();
    return _instance!;
  }

  AuthenticationController._();

  Future<bool> loginForAdmin(String email, String password) async {
    bool isLoggedIn = false;

    DataSnapshot dataSnapshot = await FirebaseDatabase.instance.ref(ADMIN_NODE).get();
    MyPrint.printOnConsole("Admin Node Value:${dataSnapshot.value}");

    if(dataSnapshot.exists && dataSnapshot.value != null) {
      Map<String, dynamic> map = {};
      try {
        map = Map.castFrom<dynamic, dynamic, String, dynamic>(dataSnapshot.value as Map);
      }
      catch(e, s) {
        MyPrint.printOnConsole("Error in Converting Admin Data To Map:${e}");
        MyPrint.printOnConsole(s);
      }

      if(map.isNotEmpty) {
        for(String key in map.keys) {
          try {
            Map<String, dynamic> adminModelMap = Map.castFrom<dynamic, dynamic, String, dynamic>(map[key]);

            UserProvider userProvider = Provider.of<UserProvider>(NavigationController().mainAppKey.currentContext!, listen: false);

            AdminLoginModel adminLoginModel = AdminLoginModel.fromMap(adminModelMap);
            adminLoginModel.id = key;
            if(adminLoginModel.email == email && adminLoginModel.pass == password) {
              userProvider.adminLoginModel = adminLoginModel;
              isLoggedIn = true;
              break;
            }
          }
          catch(e, s) {
            MyPrint.printOnConsole("Error in Converting User Data To Map:${e}");
            MyPrint.printOnConsole(s);
          }
        }
      }
    }

    return isLoggedIn;
  }

  Future<bool> loginForStudent(BuildContext context, String enrollment, String email, String password) async {
    bool isLoggedIn = false;

    DataSnapshot dataSnapshot = await FirebaseDatabase.instance.ref(STUDENTS_NODE).child(enrollment).get();
    MyPrint.printOnConsole("Admin Node Value:${dataSnapshot.value}");

    if(dataSnapshot.exists && dataSnapshot.value != null) {
      Map<String, dynamic> map = {};
      try {
        map = Map.castFrom<dynamic, dynamic, String, dynamic>(dataSnapshot.value as Map);
      }
      catch(e, s) {
        MyPrint.printOnConsole("Error in Converting Admin Data To Map:${e}");
        MyPrint.printOnConsole(s);
      }

      if(map.isNotEmpty) {
        StudentModel studentModel = StudentModel.fromMap(map);

        if(studentModel.email == email && studentModel.password == password) {
          UserProvider userProvider = Provider.of<UserProvider>(NavigationController().mainAppKey.currentContext!, listen: false);
          userProvider.studentModel = studentModel;

          isLoggedIn = true;

          Snakbar().show_success_snakbar(context, "Student Login Successful");
        }
        else {
          Snakbar().show_error_snakbar(context, "Wrong Username or Password");
        }
      }
    }
    else {
      Snakbar().show_error_snakbar(context, "Account Doesn't Exist");
    }

    return isLoggedIn;
  }

  //Will logout from system and remove data from UserProvider and local memory
  Future<bool> logout(BuildContext context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.studentModel = null;
    userProvider.adminLoginModel = null;

    Navigator.pushNamedAndRemoveUntil(context, WelcomePage.routeName, (_) => false);

    return true;
  }
}