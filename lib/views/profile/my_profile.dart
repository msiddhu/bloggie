import 'package:bloggie/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/static_components.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Profile"),),
        body:Column(
          children: [
            CommonProfile(cUser.alldetails()),
            MyStats(),
          ],
        )

    );
  }

  Container MyStats(){
   return  Container(
       child:Text("Stats"));
  }


}