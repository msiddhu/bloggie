import 'package:bloggie/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloggie/utils/custom_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Text blogTitle=Text("Bloggie",textAlign:TextAlign.center,style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color:Colors.purple[900],
  //     shadows: <Shadow>[
  //     Shadow(
  // offset: Offset(4.0, 4.0),
  // blurRadius: 10.0,
  // color: Color.fromARGB(125, 0, 0, 255),
  // ),
  // ],
  // ),
  // );


  // Container logo =Container(
  //   decoration: BoxDecoration(
  //    // color: Colors.white,
  //     shape: BoxShape.circle,
  //     boxShadow: [BoxShadow(blurRadius: 10, color: Colors.white60, spreadRadius: 10)],
  //   ),
  //   child:CircleAvatar(
  //     backgroundColor: Colors.blue[900],
  //     radius: 64.0,
  //     child: Image.asset('assets/blogIcon.png'),
  //   ),
  //
  // );







  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        // gradient: LinearGradient(
        //   begin: Alignment.center,
        //  //stops: [0.1, 0.5, 0.7, 0.9],
        //   colors: [
        //     Colors.blue[100],
        //     Colors.lightBlue,
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
              logo(),
              SizedBox(height: 25.0),
              blogTitle(),
              SizedBox(height: 100.0),
              //loginButton(),
              loginButtonv2(),

              SizedBox(height: 60,),

              Text("Read and Write Blogs",textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,
              ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class loginButtonv2 extends StatelessWidget {
  const loginButtonv2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(

          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/18,
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.black
          ),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          AssetImage('assets/google.jpg'),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),

                  Text('Sign in with Google',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ],
              )
          )
      ),
      onTap: ()async{
        AuthService().googleSignIn();
      }
    );
  }
}
