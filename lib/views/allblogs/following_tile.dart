import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowingCard extends StatelessWidget {
  Map mpdata;
 // const FollowingCard({Key key}) : super(key: key);
  FollowingCard(this.mpdata);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.lime,
        elevation: 5,
        child:Row(

          children:[
            Container(
              padding: EdgeInsets.all(10),
              child: ClipOval(child: Image.network(mpdata['photoURL'])
              ),
            ),
            SizedBox(width:25),
            Column(
              children: [
                Text(mpdata['displayName'],style:TextStyle(fontWeight: FontWeight.bold,fontSize:18 ),),
                SizedBox(height: 10,),
                Text('Likes Count : '+mpdata['likescount'].toString()),
                SizedBox(height: 10,),
                Text('Number of Blogs : '+mpdata['blogscount'].toString()),
              ],
            )
          ]
        ),

      ),
    );

    return Column(children: [

      Text(mpdata['uid']),
      Text(mpdata['photoURL']),
      Text(mpdata['displayName']),
      Text(mpdata['likescount'].toString()),
      Text(mpdata['blogscount'].toString()),
    ],);
  }
}
