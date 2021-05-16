import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/color_components.dart';
import 'package:bloggie/services/auth.dart';

import '../main.dart';
import '../services/auth.dart';
import 'login_page.dart';
class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
            child:Column(

                children:<Widget>[
                  RaisedButton(//dummy for now
                    child:Text("  Delete Account  "),
                    onPressed: () async{
                      await AuthService().deleteUser();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },),
                ]


            )

        ),
      ),
    );
  }
}