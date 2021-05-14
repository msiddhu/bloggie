

import 'package:bloggie/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/static_components.dart';

Container CommonProfile(Map mpdata) {
  String photoURL=mpdata['photoURL'];
  String displayName=mpdata['displayName'];
  String email=mpdata['email'];
  String uid=mpdata['uid'];
  var registered_date=mpdata['registeredDate'];
  String follow_text=cUser.following.contains(uid)?"Following":"Follow";

  return Container(
    decoration: BoxDecoration(color:Colors.blue[200],boxShadow: [
      BoxShadow(
      color: Colors.grey,
      offset: Offset(0.0, 1.0), //(x,y)
      blurRadius: 6.0,
    ),],
  ),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 30,),

          Row(
            children: [
              SizedBox(width: 30,),
              ClipOval(child: Image.network(photoURL)),
              SizedBox(width:25 ,),
              Column(
                children: [
                  Text(displayName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  SizedBox(height: 10,),
                  Text(email,style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  cUser.uid!=uid?
                  ElevatedButton(onPressed: ( ) {
                    if(follow_text=="Follow"){
                      followuser(uid).then((value){

                      });
                    }
                  },
                    child: Text(follow_text),
                  ):Container(),
                ],
              )

            ],
          ),
          SizedBox(height: 30,),

          //under devlopment

          Text("Registered :  "+registered_date.toDate().toString().substring(0,16),style: TextStyle(fontWeight: FontWeight.bold),),

          ],
      ),
    ),
  );
}