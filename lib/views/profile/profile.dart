import 'package:bloggie/utils/utils.dart';
import 'package:bloggie/views/profile/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:bloggie/utils/color_components.dart';

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
    Color textcolor=Theme.of(context).textTheme.headline6.color;
    return Container(
      decoration: BoxDecoration(
        color:Theme.of(context).errorColor,
      ),
      child: Column(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 20,),

                Row(
                  children: [
                    SizedBox(width: 20,),
                    Container(
                        child: ClipOval(
                            child: Image.network(photoURL)
                        ),
                      decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(
                        color: cColors.profile_image_border,
                        width: 3.0,
                      ),
                    ),
                    ),
                    SizedBox(width:18 ,),
                    Container(
                      width: MediaQuery.of(context).size.width/1.8,
                      child: Column(
                        children: [

                          Text(displayName,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:textcolor)),
                          SizedBox(height: 10,),
                          Container(
                              child: Text(email,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400,color:textcolor),)),
                          SizedBox(height: 8,),

                            Text("Registered :  "+registered_date.toDate().toString().substring(0,10),
                              style: TextStyle(fontWeight: FontWeight.w400,color:textcolor)
                              ,),
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
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).textTheme.headline1.color)),
                            child: Text(follow_text,style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor),),
                          ):Container(),
                          Stats(),
                        ],
                      ),
                    )

                  ],
                ),



              SizedBox(height: 10,),
                //Stats(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
