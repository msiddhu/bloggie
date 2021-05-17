import 'package:bloggie/utils/custom_widgets.dart';
import 'package:bloggie/utils/utils.dart';
import 'package:bloggie/views/allblogs/following_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloggie/utils/static_components.dart';

class Following extends StatefulWidget {
  const Following({Key key}) : super(key: key);

  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  List followingUid=[];
  List followingProfile=[];
  bool flag=false;
  @override
  void initState() {
    // TODO: implement initState
    followingUid=cUser.following;
    super.initState();
    filluserdata();

  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child:ListView.builder(
       // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: followingUid.length,
    itemBuilder:(context,index){
          return followingProfile[index]==null?CircleProgressBox():
          FollowingCard(
              followingProfile[index]
            );
       }

    ),
      );
  }
  filluserdata()async{
    followingProfile=List.filled(followingUid.length, null);

    for(int i=0;i<followingUid.length;i++){
      Map usermp=await getuserdetails(followingUid[i]);
      int likescount=await getlikescountofuser(usermp['uid']);
      int blogscount=await getblogscount(usermp['uid']);
      //uid
      //displayName
      //photoURL
      //likescount
      //blogscount
      Map mp={'uid':usermp['uid'],
              'displayName':usermp['displayName'],
              'photoURL':usermp['photoURL'],
              'likescount':likescount,
              'blogscount':blogscount,
      };

      setState(() {
        followingProfile[i]=mp;
      }
      );
    }


  }
}
