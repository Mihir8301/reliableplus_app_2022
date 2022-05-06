import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_file/open_file.dart';
import 'package:reliable_app/configs/constants.dart';
import 'package:reliable_app/controllers/user_controller.dart';
import 'package:reliable_app/models/student_model.dart';
import 'package:reliable_app/screens/common/components/modal_progress_hud.dart';
import 'package:reliable_app/utils/my_print.dart';
import 'package:reliable_app/utils/snakbar.dart';
import 'package:reliable_app/utils/styles.dart';

import 'facultydashboard.dart';

class FacultyAddStudent extends StatefulWidget {
  static const String routeName = "/FacultyAddStudent";

  const FacultyAddStudent({Key? key}) : super(key: key);

  @override
  _FacultyAddStudentState createState() => _FacultyAddStudentState();
}

class _FacultyAddStudentState extends State<FacultyAddStudent> {
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final fullNameEditingController = new TextEditingController();
  final enrollmentIdEditingController = new TextEditingController();
  final branchEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  File? userImageFile;

  Future<void> selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,);
    if((result?.files ?? []).isNotEmpty && (result!.files.first.path?.isNotEmpty ?? false)) {
      userImageFile = File(result.files.first.path!);
      setState(() {});
    }
  }

  Future<List<String>> uploadImages({required String studentEnrollmentId, required List<File> images}) async {
    List<String> downloadUrls = [];

    await Future.wait(images.map((File file) async {
      Uint8List bytes = file.readAsBytesSync();

      String fileName = file.path.substring(file.path.lastIndexOf("/") + 1);
      Reference reference = FirebaseStorage.instance.ref().child(STUDENTS_NODE).child(studentEnrollmentId).child(fileName);
      UploadTask uploadTask = reference.putData(bytes);
      TaskSnapshot storageTaskSnapshot;

      TaskSnapshot snapshot = await uploadTask.then((TaskSnapshot snapshot) => snapshot);
      if (snapshot.state == TaskState.success) {
        storageTaskSnapshot = snapshot;
        final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);

        print('$fileName Upload success, url:${downloadUrl}');
      }
      else {
        print('Error from image repo uploading $fileName: ${snapshot.toString()}');
        //throw ('This file is not an image');
      }
    }),
        eagerError: true, cleanUp: (_) {
          print('eager cleaned up');
        });

    return downloadUrls;
  }

  Future<void> addStudentToDatabase() async {
    setState(() {
      isloading = true;
    });

    List<String> uploadUrls = await uploadImages(studentEnrollmentId: enrollmentIdEditingController.text.trim(), images: [userImageFile!]);

    StudentModel studentModel = StudentModel(
      name: fullNameEditingController.text.trim(),
      enrollment_id: enrollmentIdEditingController.text.trim(),
      branch: branchEditingController.text.trim(),
      email: emailEditingController.text.trim(),
      password: passwordEditingController.text.trim(),
      phone: phoneNumberEditingController.text.trim(),
      createdTime: DateTime.now(),
      image: uploadUrls.isNotEmpty ? uploadUrls[0] : "",
    );

    bool isCreated = await UserController().createStudentAccount(context, studentModel);

    setState(() {
      isloading = false;
    });

    if(isCreated) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      progressIndicator: SpinKitFadingCircle(color: Styles.primaryColor,),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              getAppBar(),
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
                              getNameTextField(),
                              SizedBox(height: 20),
                              getEnrollmentTextField(),
                              SizedBox(height: 20),
                              getBranchTextField(),
                              SizedBox(height: 20),
                              getEmailTextField(),
                              SizedBox(height: 20),
                              getPasswordTextField(),
                              SizedBox(height: 20),
                              getPhoneTextField(),
                              SizedBox(height: 20),
                              getImageSelectionWidget(),
                              SizedBox(height: 20),
                              getSubmitButton(),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
            padding: EdgeInsets.only(left: 5),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, FacultyDashboard.routeName);
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
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.blueAccent,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget getNameTextField() {
    return TextFormField(
      autofocus: false,
      controller: fullNameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        fullNameEditingController.text = value!;
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
      decoration: getInputDecoration(iconData: Icons.account_circle, hint: "Enter Full Name"),
    );
  }

  Widget getEnrollmentTextField() {
    return TextFormField(
      autofocus: false,
      controller: enrollmentIdEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        enrollmentIdEditingController.text = value!;
      },
      validator: (String? value) {
        if(value?.isEmpty ?? true) {
          return "Enrollment Number Cannot Be Empty";
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.next,
      decoration: getInputDecoration(iconData: Icons.app_registration, hint: "Enter Enrollment ID"),
    );
  }

  Widget getBranchTextField() {
    return TextFormField(
      autofocus: false,
      controller: branchEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        branchEditingController.text = value!;
      },
      validator: (String? value) {
        if(value?.isEmpty ?? true) {
          return "Branch Cannot Be Empty";
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.next,
      decoration: getInputDecoration(iconData: Icons.domain, hint: "Enter Branch"),
    );
  }

  Widget getEmailTextField() {
    return TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {
          emailEditingController.text = value!;
        },
      validator: (String? value) {
        if(value?.isEmpty ?? true) {
          return "Email Cannot Be Empty";
        }
        else {
          return null;
        }
      },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Student Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
    );
  }

  Widget getPasswordTextField() {
    return TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      validator: (String? value) {
        if(value?.isEmpty ?? true) {
          return "Password Cannot Be Empty";
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.next,
      decoration: getInputDecoration(iconData: Icons.vpn_key, hint: "Enter Password"),
    );
  }

  Widget getPhoneTextField() {
    return TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      onSaved: (value) {
        phoneNumberEditingController.text = value!;
      },
      validator: (String? value) {
        if(value?.isEmpty ?? true) {
          return "Phone Cannot Be Empty";
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.done,
      decoration: getInputDecoration(iconData: Icons.phone, hint: "Enter Phone Number"),
    );
  }

  Widget getImageSelectionWidget() {
    if(userImageFile != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.4,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  child: Image.file(userImageFile!),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      userImageFile = null;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Styles.primaryColor,
                      ),
                      child: Icon(Icons.close, size: 16, color: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
          child: Row(
            children: [
              Icon(Icons.image_outlined),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Images:-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // -> Roboto-Light.ttf
                      // fontWeight: FontWeight.w100 // -> Roboto-Thin.ttf
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  selectImage();
                },
                child: Icon(Icons.add,color: Colors.blueAccent,),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget getSubmitButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          if((_formKey.currentState?.validate() ?? false) && userImageFile != null) {
            MyPrint.printOnConsole("Valid");

            addStudentToDatabase();
          }
          else if(userImageFile == null) {
            Snakbar().show_error_snakbar(context, "Please Select Profile Image");
          }
        },
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  //Supporting Widgets
  InputDecoration getInputDecoration({required IconData iconData, required String hint}) {
    return InputDecoration(
      prefixIcon: Icon(iconData),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
