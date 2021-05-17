import 'package:bloggie/utils/color_components.dart';
import 'package:bloggie/views/profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        margin: EdgeInsets.all(8),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: cColors.followingtile,
          elevation: 5,
          child:Row(
            children:[
              Container(
                margin: EdgeInsets.all(5),
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

              ),
              SizedBox(width:25),

                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                        SizedBox(
                          width:150,
                          child: AutoSizeText(mpdata['displayName'],textAlign: TextAlign.justify,
                              style:TextStyle(fontWeight: FontWeight.bold,color:textcolor ),
                            maxLines: 2,

                          ),
                        ),

                    SizedBox(height: 10,),
                    Text('Likes Count : '+mpdata['likescount'].toString(),style: TextStyle(color:textcolor),),
                    SizedBox(height: 5,),
                    Text('Number of Blogs : '+mpdata['blogscount'].toString(),style:TextStyle(color:textcolor)),
                  ],
                ),

            ]
          ),

        ),
      ),
    );

  }
}
