import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reliable_app/controllers/user_controller.dart';
import 'package:reliable_app/models/feedback_model.dart';

import '../../utils/my_print.dart';
import '../../utils/styles.dart';

class FacultyFeedback extends StatefulWidget {
  static const String routeName = "/FacultyFeedback";

  const FacultyFeedback({Key? key}) : super(key: key);

  @override
  _FacultyFeedbackState createState() => _FacultyFeedbackState();
}

class _FacultyFeedbackState extends State<FacultyFeedback> {
  late Future<List<FeedbackModel>> future;

  @override
  void initState() {
    future = UserController().getFeedbacksList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Feedbacks"),
      ),
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: future,
                builder: (BuildContext context, AsyncSnapshot<List<FeedbackModel>> snapshot) {
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

  Widget getStudentsListView(List<FeedbackModel> list) {
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

  Widget getStudentCard(FeedbackModel feedbackModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: \n${feedbackModel.name}"),
          Text("\nFeedback: \n${feedbackModel.feedback}"),
          Text("\nRating: \n${feedbackModel.rating.toStringAsFixed(1)}"),
        ],
      ),
    );
  }
}
