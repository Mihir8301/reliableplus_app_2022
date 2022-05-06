import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:reliable_app/controllers/user_controller.dart';
import 'package:reliable_app/models/student_model.dart';
import 'package:reliable_app/utils/styles.dart';

class FacultyViewList extends StatefulWidget {
  static const String routeName = "/FacultyViewList";

  const FacultyViewList({Key? key}) : super(key: key);

  @override
  _FacultyViewListState createState() => _FacultyViewListState();
}

class _FacultyViewListState extends State<FacultyViewList> {
  late Future<List<StudentModel>> future;

  @override
  void initState() {
    future = UserController().getStudentsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar( backgroundColor: Colors.blueAccent,
        title: Text("Students List"),
      ),
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                future: future,
                builder: (BuildContext context, AsyncSnapshot<List<StudentModel>> snapshot) {
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

  Widget getStudentsListView(List<StudentModel> list) {
    if(list.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
          Text("No Students",textAlign: TextAlign.center,),
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

  Widget getStudentCard(StudentModel studentModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            child: CachedNetworkImage(
              imageUrl: studentModel.image,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enrollment: ${studentModel.enrollment_id}", style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Name: ${studentModel.name}"),
                Text("Branch: ${studentModel.branch}"),
                Text("Email: ${studentModel.email}"),
                Text("Password: ${studentModel.password}"),
                Text("Phone: ${studentModel.phone}"),
                Text("Created Time: ${DateFormat("dd-MM-yyyy").format(studentModel.createdTime ?? DateTime.now())}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
