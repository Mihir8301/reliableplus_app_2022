import 'package:flutter/material.dart';
class FacultyViewList extends StatefulWidget {
  const FacultyViewList({Key? key}) : super(key: key);

  @override
  _FacultyViewListState createState() => _FacultyViewListState();
}

class _FacultyViewListState extends State<FacultyViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Faculty View List'),
            ),
          )
      ),
    );
  }
}
