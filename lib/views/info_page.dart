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
        "Info ",
        style: TextStyle(fontSize: 25, color: Theme.of(context).appBarTheme.textTheme.headline1.color),
      ),
      Text(
        "Page",
        style: TextStyle(fontSize: 25, color: Theme.of(context).appBarTheme.textTheme.headline6.color),
      ),
    ],
    ),


    ),

      body:Container(
          padding:EdgeInsets.all(20),
              margin:EdgeInsets.all(20),
          child:Column(
            children: [
              Text("hello this is info page"),
              FixedBugsText(),
            ],
          ),



        ),
    );
  }
}

class FixedBugsText extends StatelessWidget {
  const FixedBugsText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text("Fixed Bugs:"),
      ],
    ));
  }
}
