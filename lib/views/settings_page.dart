import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/static_components.dart';

import '../main.dart';
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
          child:Column(
              children:<Widget>[

                SizedBox(height: 30,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dark Mode      ",style: TextStyle(fontWeight: FontWeight.bold),),
                      Switch(
                          activeColor: Colors.blue,
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey,
                          value: cColors.darkmode,
                          onChanged: (bool value) {
                            setState(() {
                              print('Switch button: ' + value.toString());
                              cColors.darkmode=value;
                              main();
                            });
                          }
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                RaisedButton(//dummy for now
                  child:Text("  Delete Account  "),
                  onPressed: () {  },),
              ]


          )

      ),
    );
  }
}