import 'package:bloggie/services/crud.dart';
import 'package:bloggie/views/blog/blog_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloggie/services/static_components.dart';
import 'package:flutter/material.dart';

class SavedBlogs extends StatefulWidget {
  const SavedBlogs({Key key}) : super(key: key);

  @override
  _SavedBlogsState createState() => _SavedBlogsState();
}

class _SavedBlogsState extends State<SavedBlogs> with AutomaticKeepAliveClientMixin{
  List blogslist;
  List blogsmp;
  @override
  void initState() {
    print(cUser.saved_blogs);
    print(cUser.photoURL);
    blogslist=cUser.saved_blogs;
    print('saved blogslist'+blogslist.toString());
    filldata(blogslist);

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
          Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),

          height:100,
          child:CircularProgressIndicator(),
          alignment: Alignment.center,

          ):
          BlogTile(
            authorname: mpdata["authorName"],
            imgUrl:mpdata["imgUrl"],
            title:mpdata["title"],
            description: mpdata["desc"],
            time: mpdata["time"],
            documentId: mpdata["documentId"],
            issaved: (cUser.saved_blogs).contains(mpdata["documentId"]),
            likecount: mpdata["likes_count"],
            isliked: islike,
          );


        }
    );


  }
  filldata(blogslist) async{
    blogsmp=List.filled(blogslist.length, null);
    for(var i=0;i<blogslist.length;i++){
      Map mp=await CrudMethods.getData(blogslist[i]);
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
