import 'package:bloggie/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloggie/utils/static_components.dart';
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
    return Container(
      child: Column(
        children: [
          countlikes!=null?Text("Total likes: "+countlikes.toString()):Text("Loading"),
          countblogs!=null?Text("Total Blogs Written: "+countblogs.toString()):Text("Loading"),

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
