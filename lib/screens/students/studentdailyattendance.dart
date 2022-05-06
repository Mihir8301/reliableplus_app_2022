import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reliable_app/controllers/navigation_controller.dart';
import 'package:reliable_app/controllers/providers/user_provider.dart';
import 'package:reliable_app/utils/my_print.dart';

import '../../controllers/user_controller.dart';
import '../../models/daily_attendence_model.dart';
import '../../utils/styles.dart';

class StudentDailyAttendance extends StatefulWidget {
  static const String routeName = "/StudentDailyAttendance";

  const StudentDailyAttendance({Key? key}) : super(key: key);

  @override
  _StudentDailyAttendanceState createState() => _StudentDailyAttendanceState();
}

class _StudentDailyAttendanceState extends State<StudentDailyAttendance> {
  late Future<List<DailyAttendenceModel>> future;

  String getWeekDayFromInt(int day) {
    String weekday = "Monday";

    switch(day) {
      case DateTime.monday: {
        weekday = "Monday";
        break;
      }
      case DateTime.tuesday: {
        weekday = "Tuesday";
        break;
      }
      case DateTime.wednesday: {
        weekday = "Wednesday";
        break;
      }
      case DateTime.thursday: {
        weekday = "Thursday";
        break;
      }
      case DateTime.friday: {
        weekday = "Friday";
        break;
      }
      case DateTime.saturday: {
        weekday = "Saturday";
        break;
      }
      case DateTime.sunday: {
        weekday = "Sunday";
        break;
      }
    }

    return weekday;
  }

  @override
  void initState() {
    String studentId = Provider.of<UserProvider>(NavigationController().mainAppKey.currentContext!, listen: false).studentModel?.enrollment_id ?? '';
    future = UserController().getDailyAttendanceList(studentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar( backgroundColor: Colors.blueAccent,
        title: Text("Daily Attendance"),
      ),
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: future,
                builder: (BuildContext context, AsyncSnapshot<List<DailyAttendenceModel>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return getStudentsListView(snapshot.data ?? []);
                  }
                  else {
                    return Center(child: SpinKitFadingCircle(color: Styles.primaryColor,),);
                  }
                },
              ),
            ),
          )
      ),
    );
  }

  Widget getStudentsListView(List<DailyAttendenceModel> list) {
    if(list.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
          Text("No Students"),
        ],
      );
    }
    else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return getStudentCard(list[index]);
        },
      );
    }
  }

  Widget getStudentCard(DailyAttendenceModel dailyAttendenceModel) {
    String attandance = "Present";

    if((dailyAttendenceModel.datetime?.weekday ?? -1) == DateTime.sunday) {
      attandance = "Holiday";
    }
    else if(dailyAttendenceModel.attandance != "P") {
      attandance = "Absent";
    }

    MyPrint.printOnConsole("Attandance:${dailyAttendenceModel.attandance}");

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text("Attendance: ${attandance}")),
          Expanded(child: Text("Date: ${DateFormat("dd-MM-yyyy").format(dailyAttendenceModel.datetime ?? DateTime.now())}")),
          Expanded(child: Text("Day: ${getWeekDayFromInt(dailyAttendenceModel.datetime?.weekday ?? -1)}")),
        ],
      ),
    );
  }

}
