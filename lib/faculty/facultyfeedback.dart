import 'package:flutter/material.dart';


class FacultyFeedback extends StatefulWidget {
  const FacultyFeedback({Key? key}) : super(key: key);

  @override
  _FacultyFeedbackState createState() => _FacultyFeedbackState();
}

class _FacultyFeedbackState extends State<FacultyFeedback> {


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('FeedBack List'),
          ),
        )
      ),
    );
  }
}
