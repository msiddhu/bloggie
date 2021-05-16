import 'package:bloggie/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:flutter/material.dart';
class Stats extends StatefulWidget {
  const Stats({Key key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int countlikes=null;
  int countblogs=null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getstats();
  }

  @override
  Widget build(BuildContext context) {
    Color textcolor=Theme.of(context).textTheme.headline6.color;

    return Container(
      child: Column(
        children: [
          SizedBox(height: 5,),
          countlikes!=null?Text("Total Likes: "+countlikes.toString(),style: TextStyle(color:textcolor,fontWeight: FontWeight.w400 ),):Text("Loading"),
          SizedBox(height: 5,),
          countblogs!=null?Text("Total Blogs: "+countblogs.toString(),style: TextStyle(color:textcolor,fontWeight: FontWeight.w400 )):Text("Loading"),
          SizedBox(height: 5,),
        ],

    ),
    );
  }
  void getstats() async{

    getlikescountofuser(cUser.uid).then((value){
      setState(() {
        countlikes=value;
      });
    });

    getblogscount(cUser.uid).then((value){
      setState(() {
        countblogs=value;
      });
    });

  }
}
