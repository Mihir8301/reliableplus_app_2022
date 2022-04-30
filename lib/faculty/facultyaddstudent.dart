import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:reliable_app/addimage.dart';
import 'package:reliable_app/faculty/facultydashboard.dart';


class FacultyAddStudent extends StatefulWidget {
  const FacultyAddStudent({Key? key}) : super(key: key);

  @override
  _FacultyAddStudentState createState() => _FacultyAddStudentState();
}

class _FacultyAddStudentState extends State<FacultyAddStudent> {
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final fullNameEditingController = new TextEditingController();
  final enrollmentIdEditingController = new TextEditingController();
  final branchEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  FilePickerResult? result;
  PlatformFile? file;

  // final confirmPasswordEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final enrollmentIdField = TextFormField(
        autofocus: false,
        controller: enrollmentIdEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          enrollmentIdEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.app_registration),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Enrollment ID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final branchField = TextFormField(
        autofocus: false,
        controller: branchEditingController,
        keyboardType: TextInputType.name,
        onSaved: (value) {
          branchEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.domain),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Branch",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Student Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final phoneNumberField = TextFormField(
        autofocus: false,
        controller: phoneNumberEditingController,
        onSaved: (value) {
          phoneNumberEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final AddButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //  minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            //firebase mate baaki che
          },
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            Container(
              color: Colors.blueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //If Logout then ask first then Navigate
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FacultyDashboard()));
                      },
                    ),
                  ),
                  Expanded(
                    child: Text('Student Form',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // -> Roboto-Light.ttf
                            // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                            fontSize: 18.0,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 45),
                          fullNameField,
                          SizedBox(height: 20),
                          enrollmentIdField,
                          SizedBox(height: 20),
                          branchField,
                          SizedBox(height: 20),
                          emailField,
                          SizedBox(height: 20),
                          passwordField,
                          SizedBox(height: 20),
                          phoneNumberField,
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
                              child: Row(
                              children: [
                                Icon(Icons.image_outlined),
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Images:-', style: TextStyle(
                                    fontWeight: FontWeight.bold, // -> Roboto-Light.ttf
                                    // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                                    fontSize: 15.0,
                                    )),
                                )),
                                InkWell(
                                    onTap: (){
                                      pickfiless();

                                    },
                                    child: Icon(Icons.add,color: Colors.blueAccent,)),

                              ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          
                          AddButton,
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ]),
        ));
  }
  void pickfiless() async {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: true
    );
    if (result == null)
      return;
   loadSelectedFile(result!.files);

  }
  void loadSelectedFile(List<PlatformFile> files)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddImage(files:files,onOpenedFile: viewFile)));
  }
  void viewFile(PlatformFile file)
  {
    OpenFile.open(file.path);
  }
}
