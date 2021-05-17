import 'package:bloggie/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloggie/utils/custom_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {








  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
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

              loginButton(),

              SizedBox(height: 60,),

              Text("Read and Write Blogs",textAlign: TextAlign.center,style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,fontSize: 20,fontWeight: FontWeight.bold,
              ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class loginButton extends StatelessWidget {
  const loginButton({
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
