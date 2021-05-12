import 'package:bloggie/main.dart';
import 'package:bloggie/services/crud.dart';
import 'package:bloggie/services/static_components.dart';
import 'package:bloggie/views/blog/blog_create_page.dart';
import 'package:bloggie/views/nav_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'blog/blog_tile.dart';
import 'dart:developer' as developer;


class HomePage extends StatefulWidget {




  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  CrudMethods crudMethods = new CrudMethods();
  Stream blogsStream;
  bool st=false;
  Widget blogsList() {

    return Container(


      child: StreamBuilder<QuerySnapshot>(
        stream: blogsStream,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          else{
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                var mpdata=ds.data() as Map;
                List like_user_ids=mpdata["liked_user_ids"]==null?["nothing"]:mpdata["liked_user_ids"];
                developer.log(like_user_ids.toString(),name:"liked_user_ids");
                //developer.log(cUser.uid,name:"liked_user_id");

                bool islike=like_user_ids.contains(cUser.uid);
                developer.log(islike.toString(),name:"isLiked");
                return BlogTile(
                authorname: mpdata["authorName"],
                imgUrl: mpdata["imgUrl"],
                title:mpdata["title"],
                description: mpdata["desc"],
                time: mpdata["time"],
                documentId: mpdata["documentId"],
                issaved: (cUser.saved_blogs).contains(mpdata["documentId"]),
                likecount: mpdata["likes_count"],

                isliked: islike,
                );
              },
            );

          }
        },
      ),
    );
  }

  @override
  initState()  {
    super.initState();
    crudMethods.getAllData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "B",
            style: TextStyle(fontSize: 50, color: Colors.blue[900]),
          ),
          Text(
            "loggie",
            style: TextStyle(fontSize: 25, color: Colors.blue[50]),
          ),],),

        actions:<Widget>[ Switch(
            activeColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.grey,
            value: cColors.darkmode,
            onChanged: (bool value) {
              setState(() {
                print('Switch button: ' + value.toString());
                cColors.darkmode=value;
                main();
              });
            }
        ),],

      ),
      body: blogsStream!=null?
      blogsList():
      Container(),
      floatingActionButton: Container(
        //padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(

              backgroundColor: Colors.yellow[600],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              icon: Icon(Icons.add),
              label: Text("Add Post"),
            ),

          ],
        ),
      ),
    );
  }
}
