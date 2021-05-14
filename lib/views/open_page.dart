import 'package:bloggie/utils/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpenPage extends StatefulWidget {
  const OpenPage({Key key}) : super(key: key);

  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {






  @override
  Widget build(BuildContext context) {
    print('openpage raaa');
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        // gradient: LinearGradient(
        //   begin: Alignment.center,
        //   //stops: [0.1, 0.5, 0.7, 0.9],
        //   colors: [
        //     Colors.grey,
        //     Colors.lightBlue,
        //     Colors.white,
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

              // alignment: Alignment.center,
              CircleProgress(),
              SizedBox(height: 60,),
              Text("Read and Write Blogs",textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,
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
