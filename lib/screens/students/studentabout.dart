import 'package:flutter/material.dart';

class StudentAbout extends StatefulWidget {
  static const String routeName = "/StudentAbout";

  const StudentAbout({Key? key}) : super(key: key);

  @override
  _StudentAboutState createState() => _StudentAboutState();
}

class _StudentAboutState extends State<StudentAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "About Us",
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "Reliable+ is an mobile application that eradicates the usage of registers for attendance purpose.To achieve its purpose face recognition and mask detection based modern technologies are being used.By taking advantage of the latest technologies it is useful in minimising the risks occuring during pandemic situation, as it replaces the biometric system avoiding the touch system.",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Developed By:-",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mihir Jadeja",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Krutik Rathod",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Vraj Patel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                )
              ],
            )),
      )),
    );
  }
}
