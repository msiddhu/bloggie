import 'package:bloggie/services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/static_components.dart';

class Profile extends StatefulWidget {
  Map mpdata;
  Profile(this.mpdata);
  //const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    List blogs=widget.mpdata['blogs'];
    String photoURL=widget.mpdata['photoURL'];
    String displayName=widget.mpdata['displayName'];
    String email=widget.mpdata['email'];
    String uid=widget.mpdata['uid'];
    var registered_date=widget.mpdata['registeredDate'];
    String follow_text=cUser.following.contains(uid)?"Following":"Follow";
    return Container(
      decoration: BoxDecoration(color:Colors.green[200],boxShadow: [
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
                        followuser(uid).then((_){
                          setState(() {
                            follow_text="Unfollow";
                          }); });}
                      else{
                        unfollowuser(uid).then((_){
                          setState(() {
                            follow_text="Follow";
                          }
                          );
                        }
                        );
                      }

                    },
                      child: Text(follow_text),
                    ):Container(),
                  ],
                )

              ],
            ),
            SizedBox(height: 30,),


            Text("Registered :  "+registered_date.toDate().toString().substring(0,16),style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
