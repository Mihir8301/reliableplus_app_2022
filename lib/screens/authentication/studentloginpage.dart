import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reliable_app/controllers/authentication_controller.dart';

import '../students/studentdashboard.dart';

class StudentLoginPage extends StatefulWidget {
  static const String routeName = "/StudentLoginPage";

  const StudentLoginPage({Key? key}) : super(key: key);

  @override
  _StudentLoginPageState createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController enrollmentController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 250,
                      child: Image.asset(
                        "assets/TransparentLogo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45),
                    getEnrollmentTextField(),
                    SizedBox(height: 25),
                    getEmailTextField(),
                    SizedBox(height: 25),
                    getPasswordTextField(),
                    SizedBox(height: 35),
                    getLoginButton(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getEnrollmentTextField() {
    return TextFormField(
      autofocus: false,
      controller: enrollmentController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        enrollmentController.text = value!;
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
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.insert_drive_file),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enrollment Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget getEmailTextField() {
    return TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
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
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget getPasswordTextField() {
    return TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (String? value) {
        if(value?.isEmpty ?? true) {
          return "Password Cannot Be Empty";
        }
        else {
          return null;
        }
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget getLoginButton() {
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

            bool isLoggedIn = await AuthenticationController().loginForStudent(context, enrollmentController.text.trim(), emailController.text.trim(), passwordController.text.trim());

            setState(() {
              isLoading = false;
            });

            if(isLoggedIn) {
              Navigator.pushNamedAndRemoveUntil(context, StudentDashboard.routeName, (_) => false);
            }
          }
        },
        child: isLoading ? SpinKitThreeBounce(color: Colors.white, size: 26,) : Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


