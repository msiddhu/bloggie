import 'package:bloggie/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {





  bool loading=false;

  Text blogTitle=Text("Bloggie",textAlign:TextAlign.center,style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color:Colors.purple[900],
      shadows: <Shadow>[
  //     Shadow(
  //     offset: Offset(10.0, 10.0),
  //   blurRadius: 3.0,
  //   color: Color.fromARGB(255, 0, 0, 0),
  // ),
      Shadow(
  offset: Offset(4.0, 4.0),
  blurRadius: 10.0,
  color: Color.fromARGB(125, 0, 0, 255),
  ),
  ],
  ),);


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




  Container loginButton = Container(
    //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),

    child: RaisedButton(

      //padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 3.0),
        color: const Color(0xFF4285F4),
        onPressed: () async {
          AuthService().googleSignIn();
        },

        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(
              'assets/icons8-google-48.png',
            ),


            new Container(
              //padding: EdgeInsets.only(left: 10.0,right: 10.0),
                child: new Text("Sign in with Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),)
            ),
          ],
        )),
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:DecorationImage(
          image:AssetImage('assets/background.png'),
          fit:BoxFit.cover,
        )
        // gradient: LinearGradient(
        //   begin: Alignment.center,
        //  //stops: [0.1, 0.5, 0.7, 0.9],
        //   colors: [
        //     Colors.blue[100],
        //
        //     Colors.lightBlue,
        //
        //     Colors.blue[800],
        //
        //   ],
        //   tileMode: TileMode.mirror,
        // ),
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
              loginButton,

            ],
          ),
        ),
      ),
    );
  }
}
