import 'package:bloggie/views/profile/profile.dart';
import 'package:bloggie/views/profile/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/static_components.dart';

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
            Profile(cUser.alldetails()),
            Stats(),
          ],
        )

    );
  }




}