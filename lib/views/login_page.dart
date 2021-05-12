import 'package:bloggie/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {





  bool loading=false;

  Text blogTitle=Text(

    "Bloggie",style:TextStyle(fontSize: 30),
    textAlign: TextAlign.center,
  );

  Hero logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.white,
      radius: 96.0,
      child: Image.asset('assets/blogIcon.png'),
    ),
  );


  Container loginButton = Container(
    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),

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
                child: new Text("Sign in with Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
            ),
          ],
        )),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            // SizedBox(height: 25.0),
            blogTitle,
            SizedBox(height: 50.0),
            loginButton,

          ],
        ),
      ),
    );
  }
}
