import 'package:bloggie/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProgress extends StatelessWidget {
  const CircleProgress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:CircularProgressIndicator(

        backgroundColor: Colors.red,
        strokeWidth: 10.0,

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
    return     Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),

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


               Container(
                //padding: EdgeInsets.only(left: 10.0,right: 10.0),
                  child:Text("Sign in with Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),)
              ),
            ],
          )),
    );
  }
}




class blogTitle extends StatelessWidget {
  const blogTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Text("Bloggie",
      textAlign:TextAlign.center,style:
      TextStyle(fontSize: 40,
        fontWeight:FontWeight.bold,
        color:Colors.purple[900],
        shadows: <Shadow>[
          Shadow(
            offset: Offset(4.0, 4.0),
            blurRadius: 10.0,
            color: Color.fromARGB(125, 0, 0, 255),
          ),
        ],
      ),
    );
  }
}

class logo extends StatelessWidget {
  const logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return     Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.white60, spreadRadius: 10)],
      ),
      child:CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: 64.0,
        child: Image.asset('assets/blogIcon.png'),
      ),

    );
  }
}

class CircleProgressBox extends StatelessWidget {
  const CircleProgressBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30)),
      height:100,
      child:CircleProgress(),
      alignment: Alignment.center,
    );
  }
}