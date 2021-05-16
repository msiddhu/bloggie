import 'package:bloggie/services/crud.dart';
import 'package:bloggie/views/blog_crud/blog_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/custom_widgets.dart';


class AllBlogs extends StatefulWidget {
  List bloglist;
  bool neverscroll;
 // const SavedBlogs({Key key}) : super(key: key);
  AllBlogs(this.bloglist,this.neverscroll);

  @override
  _AllBlogsState createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> with AutomaticKeepAliveClientMixin{
  List blogslist=[];
  List blogsmp=[];
  @override
  void initState() {
    print(widget.bloglist);
    blogslist=widget.bloglist;
    fillBlogData(blogslist);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.neverscroll){
    return Container(
      //decoration: BoxDecoration(color: Colors.blue),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: blogslist.length,
          itemBuilder:(context,index){
            Map mpdata=blogsmp[index];
            bool islike=false;
            if(mpdata!=null){
            List like_user_ids=mpdata["liked_user_ids"]==null?["nothing"]:mpdata["liked_user_ids"];
            islike=like_user_ids.contains(cUser.uid);
            }
            return blogsmp[index]==null?
            CircleProgressBox():
            BlogTile(
              uid:mpdata['uid'],
              authorname: mpdata["authorName"],
              imgUrl:mpdata["imgUrl"],
              title:mpdata["title"],
              description: mpdata["desc"],
              time: mpdata["time"],
              documentId: mpdata["documentId"],
              issaved: (cUser.savedBlogs).contains(mpdata["documentId"]),
              likecount: 0,
              isliked: islike,
            );


          }
      ),
    );}
    else{
      return ListView.builder(
          shrinkWrap: true,
          itemCount: blogslist.length,
          itemBuilder:(context,index){
            Map mpdata=blogsmp[index];
            bool islike=false;
            if(mpdata!=null){
              List like_user_ids=mpdata["liked_user_ids"]==null?["nothing"]:mpdata["liked_user_ids"];
            islike=like_user_ids.contains(cUser.uid);
            }
            return blogsmp[index]==null?
            CircleProgressBox():
            BlogTile(
            uid:mpdata['uid'],
            authorname: mpdata["authorName"],
            imgUrl:mpdata["imgUrl"],
            title:mpdata["title"],
            description: mpdata["desc"],
            time: mpdata["time"],
            documentId: mpdata["documentId"],
            issaved: (cUser.savedBlogs).contains(mpdata["documentId"]),
            likecount: 0,
            isliked: islike,
            );


          }
      );
    }


  }
  fillBlogData(blogslist) async{
    blogsmp=List.filled(blogslist.length, null);
    for(var i=0;i<blogslist.length;i++){
      Map mp=await CrudMethods.getBlogData(blogslist[i]);
      setState(() {
        blogsmp[i]=mp;
      }
      );


    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}


