import 'package:reliable_app/configs/constants.dart';
import 'package:reliable_app/models/daily_attendence_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:reliable_app/models/feedback_model.dart';
import 'package:reliable_app/models/student_model.dart';
import 'package:reliable_app/utils/my_print.dart';
import 'package:reliable_app/utils/snakbar.dart';

class UserController {
  static UserController? _instance;

  factory UserController() {
    _instance ??= UserController._();
    return _instance!;
  }

  UserController._();

  Future<bool> createStudentAccount(BuildContext context,StudentModel studentModel) async {
    try {
      Map<String, dynamic> data = studentModel.tomap();

      DatabaseReference databaseReference = FirebaseDatabase.instance.ref(STUDENTS_NODE).child(studentModel.enrollment_id);
      DataSnapshot dataSnapshot = await databaseReference.get();

      bool isSuccess = false;

      if(dataSnapshot.exists) {
        Snakbar().show_error_snakbar(context, "Student Already Exist");
      }
      else {
        isSuccess = await databaseReference.set(data).then((value) {
          Snakbar().show_success_snakbar(context, "Student Added Successfully");

          return true;
        })
        .catchError((e) {
          Snakbar().show_error_snakbar(context, "Error in Adding Student:${e}");
          return false;
        });
      }

      return isSuccess;
    }
    catch(e) {
      MyPrint.printOnConsole("Error in UserController.createUser:${e}");
    }

    return false;
  }

  Future<List<StudentModel>> getStudentsList() async {
    List<StudentModel> studentsList = [];

    DataSnapshot dataSnapshot = await FirebaseDatabase.instance.ref(STUDENTS_NODE).get();

    if(dataSnapshot.exists && dataSnapshot.value != null) {
      Map<String, dynamic> map = {};
      try {
        map = Map.castFrom<dynamic, dynamic, String, dynamic>(dataSnapshot.value as Map);
      }
      catch(e, s) {
        MyPrint.printOnConsole("Error in Converting User Data To Map:${e}");
        MyPrint.printOnConsole(s);
      }

      if(map.isNotEmpty) {
        for(String key in map.keys) {
          try {
            Map<String, dynamic> studentModelMap = Map.castFrom<dynamic, dynamic, String, dynamic>(map[key]);

            StudentModel studentModel = StudentModel.fromMap(studentModelMap);
            studentsList.add(studentModel);
            MyPrint.printOnConsole("studentModel:${studentModel}");
          }
          catch(e, s) {
            MyPrint.printOnConsole("Error in Converting User Data To Map:${e}");
            MyPrint.printOnConsole(s);
          }
        }
      }
    }

    return studentsList;
  }

  Future<List<DailyAttendenceModel>> getDailyAttendanceList(String studentId) async {
    List<DailyAttendenceModel> attendanceList = [];

    if(studentId.isNotEmpty) {
      DataSnapshot dataSnapshot = await FirebaseDatabase.instance.ref(ATTENDANCE_NODE).child(studentId).get();

      if(dataSnapshot.exists && dataSnapshot.value != null) {
        Map<String, dynamic> map = {};
        try {
          map = Map.castFrom<dynamic, dynamic, String, dynamic>(dataSnapshot.value as Map);
        }
        catch(e, s) {
          MyPrint.printOnConsole("Error in Converting User Data To Map:${e}");
          MyPrint.printOnConsole(s);
        }

        if(map.isNotEmpty) {
          for(String key in map.keys) {
            try {
              Map<String, dynamic> attendanceModelMap = Map.castFrom<dynamic, dynamic, String, dynamic>(map[key]);

              DailyAttendenceModel dailyAttendenceModel = DailyAttendenceModel.fromMap(attendanceModelMap);
              attendanceList.add(dailyAttendenceModel);
              MyPrint.printOnConsole("dailyAttendenceModel:${dailyAttendenceModel}");
            }
            catch(e, s) {
              MyPrint.printOnConsole("Error in Converting Attendance Data To Map:${e}");
              MyPrint.printOnConsole(s);
            }
          }

          if(attendanceList.isNotEmpty) {
            attendanceList.sort((a, b) {
              return (a.datetime ?? DateTime.now()).compareTo(b.datetime ?? DateTime.now());
            });

            DateTime firstDate = attendanceList.first.datetime ?? DateTime.now();
            DateTime lastDate = attendanceList.last.datetime ?? DateTime.now();

            if(lastDate.isAfter(firstDate)) {
              firstDate = firstDate.add(Duration(days: 1));
              while(firstDate.day != lastDate.day || firstDate.month != lastDate.month || firstDate.year != lastDate.year) {
                List<DailyAttendenceModel> list = attendanceList.where((element) {
                  DateTime dateTime = element.datetime ?? DateTime.now();
                  return dateTime.day == firstDate.day && dateTime.month == firstDate.month && dateTime.year == firstDate.year;
                }).toList();
                if(list.isEmpty) {
                  attendanceList.add(DailyAttendenceModel(datetime: firstDate, attandance: "A"));
                }
                firstDate = firstDate.add(Duration(days: 1));
              }

              attendanceList.sort((a, b) {
                return (a.datetime ?? DateTime.now()).compareTo(b.datetime ?? DateTime.now());
              });
            }
          }
        }
      }
    }

    return attendanceList;
  }

  Future<bool> createFeedback(FeedbackModel feedbackModel) async {
    bool isSuccessfull = false;

    DatabaseReference databaseReference = await FirebaseDatabase.instance.ref(FEEDBACK_NODE).push();
    feedbackModel.id = databaseReference.key ?? "";
    isSuccessfull = await databaseReference.set(feedbackModel.tomap()).then((value) {
      return true;
    })
    .catchError((e) {
      return false;
    });

    return isSuccessfull;
  }

  Future<List<FeedbackModel>> getFeedbacksList() async {
    List<FeedbackModel> feedbacks = [];

    DataSnapshot dataSnapshot = await FirebaseDatabase.instance.ref(FEEDBACK_NODE).get();
    MyPrint.printOnConsole("Feedback Node Value:${dataSnapshot.value}");

    if(dataSnapshot.exists && dataSnapshot.value != null) {
      Map<String, dynamic> map = {};
      try {
        map = Map.castFrom<dynamic, dynamic, String, dynamic>(dataSnapshot.value as Map);
      }
      catch(e, s) {
        MyPrint.printOnConsole("Error in Converting Feedback Data To Map:${e}");
        MyPrint.printOnConsole(s);
      }

      if(map.isNotEmpty) {
        for(String key in map.keys) {
          try {
            Map<String, dynamic> feedbackModelMap = Map.castFrom<dynamic, dynamic, String, dynamic>(map[key]);

            FeedbackModel feedbackModel = FeedbackModel.fromMap(feedbackModelMap);
            feedbacks.add(feedbackModel);
          }
          catch(e, s) {
            MyPrint.printOnConsole("Error in Converting Feedback Model Data To Map:${e}");
            MyPrint.printOnConsole(s);
          }
        }
      }
    }

    return feedbacks;
  }




  Future<void> createDailyAttandanceForUser(String studentId) async {
    if(studentId.isEmpty) return;

    List<DailyAttendenceModel> list = [
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 1)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 5)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 6)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 7)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 14)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 15)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 28)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 4, 30)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 5, 1)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 5, 3)),
      DailyAttendenceModel(attandance: "P", datetime: DateTime(2022, 5, 4)),
    ];

    list.forEach((DailyAttendenceModel dailyAttendenceModel) {
      FirebaseDatabase.instance.ref(ATTENDANCE_NODE).child(studentId).push().set(dailyAttendenceModel.tomap());
    });
  }
}