import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
    title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Text(
        "Info",
        style: TextStyle(fontSize: 25, color: Colors.amber),
      ),
      Text(
        "Page",
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    ],
    ),


    ),

      body: Container(
        child:Text("hello this is info page"),
      ),
    );
  }
}
