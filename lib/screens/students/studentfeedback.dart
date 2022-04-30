import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reliable_app/controllers/user_controller.dart';
import 'package:reliable_app/models/feedback_model.dart';
import 'package:reliable_app/utils/snakbar.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import 'studentdashboard.dart';

class StudentFeedback extends StatefulWidget {
  static const String routeName = "/StudentFeedback";

  const StudentFeedback({Key? key}) : super(key: key);

  @override
  _StudentFeedbackState createState() => _StudentFeedbackState();
}

class _StudentFeedbackState extends State<StudentFeedback> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController queryController = new TextEditingController();
  var rating = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getAppBar(),
            SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10, right: 10), child: getNameTextField()),
                      SizedBox(height: 25),
                      Padding(padding: EdgeInsets.only(left: 10, right: 10), child: getFeedbackTextField()),
                      getRatingWidget(),
                      SizedBox(height: 25),
                      Padding(padding: EdgeInsets.only(left: 10, right: 10), child: getSubmitButton()),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBar() {
    return Container(
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //If Logout then ask first then Navigate
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, StudentDashboard.routeName);
              },
            ),
          ),

          Expanded(
            child: Text('FeedBack Form',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, // -> Roboto-Light.ttf
                    // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                    fontSize: 18.0,
                    color: Colors.white)),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.blueAccent,
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getNameTextField() {
    return TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          nameController.text = value!;
        },
        validator: (String? value) {
          if(value?.isEmpty ?? true) {
            return "Name Cannot Be Empty";
          }
          else {
            return null;
          }
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }

  Widget getFeedbackTextField() {
    return TextFormField(
        autofocus: false,
        controller: queryController,
        maxLines: 10,
        textInputAction: TextInputAction.done,
        onSaved: (value) {
          queryController.text = value!;
        },
        validator: (String? value) {
          if(value?.isEmpty ?? true) {
            return "Name Cannot Be Empty";
          }
          else {
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your FeedBack",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }

  Widget getRatingWidget() {
    return SmoothStarRating(
      rating: rating,
      size: 30,
      allowHalfRating: true,
      onRatingChanged: (value) {
        setState(() {
          rating = value;
        });
      },
    );
  }

  Widget getSubmitButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if(_formKey.currentState?.validate() ?? false) {
            setState(() {
              isLoading = true;
            });

            FeedbackModel feedbackModel = FeedbackModel(
              name: nameController.text.trim(),
              feedback: queryController.text.trim(),
              rating: rating,
            );

            bool isFeedbackSuccessfull = await UserController().createFeedback(feedbackModel);

            setState(() {
              isLoading = false;
            });

            if(isFeedbackSuccessfull) {
              Snakbar().show_success_snakbar(context, "Feedback Successful");
              Navigator.pop(context);
            }
            else {
              Snakbar().show_error_snakbar(context, "Feedback Failed");
            }
          }
        },
        child: isLoading ? SpinKitThreeBounce(color: Colors.white, size: 20,) : Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
