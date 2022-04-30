import 'package:flutter/material.dart';
import 'package:reliable_app/welcomepage.dart';

class LogoutScreen extends StatelessWidget {
  LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:Colors.blueAccent
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(

                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          offset: Offset(-6.0, -6.0),
                          blurRadius: 16.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(6.0, 6.0),
                          blurRadius: 16.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white
                  ),



                  child: Icon(Icons.priority_high,color: Colors.black,)),
              SizedBox(height: 10,),
              Text('Are  you sure ',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
              SizedBox(height: 3,),
              Text('Do you want to Logout? ',style: TextStyle(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Row(
                children: [

                  Expanded(

                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.1),
                                  offset: Offset(-6.0, -6.0),
                                  blurRadius: 16.0,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 16.0,
                                ),],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),

                          child: Text('Cancel',textAlign: TextAlign.center,style: TextStyle(color: Colors.black54),)
                      ),
                    ),
                  ),



                  SizedBox(width: 10,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WelcomePage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                offset: Offset(-6.0, -6.0),
                                blurRadius: 16.0,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              ),],
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),

                        child: Text('Logout',textAlign: TextAlign.center,style: TextStyle(color: Colors.black54),),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),

        ),
      ),

    );
  }
}