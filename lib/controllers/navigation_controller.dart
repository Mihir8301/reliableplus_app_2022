import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reliable_app/splash_screen.dart';
import 'package:reliable_app/utils/my_print.dart';

import '../screens/authentication/facultyloginpage.dart';
import '../screens/authentication/studentloginpage.dart';
import '../screens/authentication/welcomepage.dart';
import '../screens/faculty/facultyabout.dart';
import '../screens/faculty/facultyaddstudent.dart';
import '../screens/faculty/facultydashboard.dart';
import '../screens/faculty/facultyfeedback.dart';
import '../screens/faculty/facultyprofileinformation.dart';
import '../screens/faculty/facultysignuppage.dart';
import '../screens/faculty/facultyviewlist.dart';
import '../screens/students/studentabout.dart';
import '../screens/students/studentdailyattendance.dart';
import '../screens/students/studentdashboard.dart';
import '../screens/students/studentfeedback.dart';
import '../screens/students/studentprofileinformation.dart';

class NavigationController {
  static NavigationController? _instance;

  factory NavigationController() {
    return _instance ??= NavigationController._();
  }

  NavigationController._();

  GlobalKey<NavigatorState> mainAppKey = GlobalKey<NavigatorState>();

  Route? onGeneratedRoutes(RouteSettings routeSettings) {
    MyPrint.printOnConsole("OnGeneratedRoutes Called for ${routeSettings.name} with arguments:${routeSettings.arguments}");

    Widget? widget;

    switch(routeSettings.name) {
      case SplashScreen.routeName : {
        widget = const SplashScreen();
        break;
      }
      case FacultyLoginPage.routeName : {
        widget = const FacultyLoginPage();
        break;
      }
      case StudentLoginPage.routeName : {
        widget = const StudentLoginPage();
        break;
      }
      case WelcomePage.routeName : {
        widget = const WelcomePage();
        break;
      }
      case FacultyAbout.routeName : {
        widget = const FacultyAbout();
        break;
      }
      case FacultyAddStudent.routeName : {
        widget = const FacultyAddStudent();
        break;
      }
      case FacultyDashboard.routeName : {
        widget = FacultyDashboard();
        break;
      }
      case FacultyFeedback.routeName : {
        widget = const FacultyFeedback();
        break;
      }
      case FacultyProfileInformation.routeName : {
        widget = const FacultyProfileInformation();
        break;
      }
      case FacultySignupPage.routeName : {
        widget = const FacultySignupPage();
        break;
      }
      case FacultyViewList.routeName : {
        widget = const FacultyViewList();
        break;
      }
      case StudentAbout.routeName : {
        widget = const StudentAbout();
        break;
      }
      case StudentDailyAttendance.routeName : {
        widget = const StudentDailyAttendance();
        break;
      }
      case StudentDashboard.routeName : {
        widget = const StudentDashboard();
        break;
      }
      case StudentFeedback.routeName : {
        widget = const StudentFeedback();
        break;
      }
      case StudentProfileInformation.routeName : {
        widget = const StudentProfileInformation();
        break;
      }
    }

    if(widget != null)return MaterialPageRoute(builder: (_) => widget!);
  }
}