import 'package:flutter/material.dart';
class StudentDailyAttendance extends StatefulWidget {
  const StudentDailyAttendance({Key? key}) : super(key: key);

  @override
  _StudentDailyAttendanceState createState() => _StudentDailyAttendanceState();
}

class _StudentDailyAttendanceState extends State<StudentDailyAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Student Daily Attendance Page'),
            ),
          )
      ),
    );
  }
}
