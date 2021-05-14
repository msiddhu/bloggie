import 'package:bloggie/services/utils.dart';
import 'package:bloggie/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  String uid;
  UserProfile(
      this.uid
      );

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool flag=false;
  Map mp={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdetails(widget.uid).then((value){

      mp=value;
      setState(() {
        print("yes flag");
      flag=true;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("User Profile"),
      ),
      body:Column(
          children:[
            flag?CommonProfile(mp):Container(child:Text(widget.uid)),
            UserBlogs(),

          ]
      ),
    );
  }

  Container UserBlogs(){
    return Container(
      child:Text("User Posts"),
    );
  }
}
