import 'package:bloggie/services/auth.dart';
import 'package:bloggie/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'connector.dart';

class OpenPage extends StatefulWidget {
  const OpenPage({Key key}) : super(key: key);

  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {

  bool loading=false;
  Text blogTitle=Text("Bloggie",textAlign:TextAlign.center,style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color:Colors.purple[900],
    shadows: <Shadow>[
      Shadow(
        offset: Offset(4.0, 4.0),
        blurRadius: 10.0,
        color: Color.fromARGB(125, 0, 0, 255),
      ),
    ],
  ),
  );


  Container logo =Container(
    decoration: BoxDecoration(
      // color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(blurRadius: 10, color: Colors.white60, spreadRadius: 10)],
    ),
    child:CircleAvatar(
      backgroundColor: Colors.blue[900],
      radius: 64.0,
      child: Image.asset('assets/blogIcon.png'),
    ),

  );

  @override
  Widget build(BuildContext context) {
    print('openpage raaa');
    return Container(
      decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage('assets/background.png'),
            fit:BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height/5),
              logo,
              SizedBox(height: 25.0),
              blogTitle,
              SizedBox(height: 100.0),

                     // alignment: Alignment.center,
              Container(
                alignment: Alignment.center,
                child:CircularProgressIndicator(

                  backgroundColor: Colors.red,
                  strokeWidth: 10.0,

                ),
              ),



              //loginButton,

            ],
          ),
        ),
      ),
    );
  }

}
