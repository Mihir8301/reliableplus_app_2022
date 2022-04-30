import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reliable_app/controllers/authentication_controller.dart';
import 'package:reliable_app/screens/common/components/modal_progress_hud.dart';
import 'package:reliable_app/utils/my_print.dart';
import 'package:reliable_app/utils/snakbar.dart';
import 'package:reliable_app/utils/styles.dart';

import '../faculty/facultydashboard.dart';

class FacultyLoginPage extends StatefulWidget {
  static const String routeName = "/FacultyLoginPage";

  const FacultyLoginPage({Key? key}) : super(key: key);

  @override
  _FacultyLoginPageState createState() => _FacultyLoginPageState();
}

class _FacultyLoginPageState extends State<FacultyLoginPage> {
  bool isLoading = false;

  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
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
                            height: 300,
                            child: Image.asset(
                              "assets/TransparentLogo.png",
                              fit: BoxFit.contain,
                            )),
                        SizedBox(height: 5),
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
      validator: (String? val) {
        if(val?.isEmpty ?? true) {
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
        validator: (String? val) {
          if(val?.isEmpty ?? true) {
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

            bool isLoggedIn = await AuthenticationController().loginForAdmin(emailController.text.trim(), passwordController.text.trim());
            MyPrint.printOnConsole("IsAdminLoggedIn:${isLoggedIn}");

            setState(() {
              isLoading = false;
            });

            if(isLoggedIn) {
              Snakbar().show_success_snakbar(context, "Login Successfull");
            }
            else {
              Snakbar().show_error_snakbar(context, "Wrong Email Or Password");
            }

            if(isLoggedIn) {
              Navigator.pushNamedAndRemoveUntil(context, FacultyDashboard.routeName, (_) => false);
            }
          }
        },
        child: isLoading ? SpinKitThreeBounce(color: Colors.white, size: 24,) : Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

