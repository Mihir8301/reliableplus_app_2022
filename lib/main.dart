import 'package:flutter/material.dart';
import 'package:reliable_app/splashscreen.dart';
import 'package:reliable_app/welcomepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: SplashScreen()
    );
  }
}
