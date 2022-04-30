import 'package:flutter/material.dart';
import 'package:reliable_app/students/studentdashboard.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class StudentFeedback extends StatefulWidget {
  const StudentFeedback({Key? key}) : super(key: key);

  @override
  _StudentFeedbackState createState() => _StudentFeedbackState();
}

class _StudentFeedbackState extends State<StudentFeedback> {
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController queryController = new TextEditingController();
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final NameField = TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final QueryField = TextFormField(
        autofocus: false,
        controller: queryController,
        maxLines: 10,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your FeedBack",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final SubmitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        //   minWidth: MediaQuery.of(context).size.width,
        onPressed: ()
            // by pressing it goes to faculty query form
            {},
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Container(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentDashboard()));
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
            ],
          ),
        ),
        SizedBox(height: 40),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: NameField),
                SizedBox(height: 25),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: QueryField),
                SizedBox(height: 15),
                // List.generate(5, (index) {
                //   return Icon(index <value ?
                //   Icons.star  :
                //       Icons.star_border,
                //   );
                // }),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 10.0),
                //       child: Row(
                //         children: [
                //           SmoothStarRating(),
                //         ],
                //       ),
                //     ),
                SmoothStarRating(
                  rating: rating,
                  size: 30,
                  allowHalfRating: true,
                  onRatingChanged: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                SizedBox(height: 25),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SubmitButton),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
