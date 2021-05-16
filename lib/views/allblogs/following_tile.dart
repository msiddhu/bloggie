import 'package:bloggie/utils/color_components.dart';
import 'package:bloggie/views/profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowingCard extends StatelessWidget {
  Map mpdata;
 // const FollowingCard({Key key}) : super(key: key);
  FollowingCard(this.mpdata);
  @override
  Widget build(BuildContext context) {
    Color titlecolor=Theme.of(context).textTheme.headline1.color;
    Color textcolor=Theme.of(context).textTheme.headline6.color;
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserProfile(mpdata['uid'])));
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: cColors.followingtile,
          elevation: 5,
          child:Row(
            children:[
              Container(
                padding: EdgeInsets.all(10),
                child:Container(
                  child: ClipOval(
                      child: Image.network(mpdata['photoURL'])
                  ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: cColors.profile_image_border,
                      width: 3.0,
                    ),
                  ),
                ),

               // child: ClipOval(child: Image.network(mpdata['photoURL'])
               // ),
              ),
              SizedBox(width:25),
              Column(
                children: [
                  Text(mpdata['displayName'],style:TextStyle(fontWeight: FontWeight.bold,fontSize:18,color:textcolor ),),
                  SizedBox(height: 10,),
                  Text('Likes Count : '+mpdata['likescount'].toString(),style: TextStyle(color:textcolor),),
                  SizedBox(height: 10,),
                  Text('Number of Blogs : '+mpdata['blogscount'].toString(),style:TextStyle(color:textcolor)),
                ],
              )
            ]
          ),

        ),
      ),
    );

  }
}
