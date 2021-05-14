import 'package:bloggie/services/crud.dart';
import 'package:bloggie/services/static_components.dart';
import 'package:bloggie/views/blog/blog_create.dart';
import 'package:bloggie/views/nav_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'blog/blog_tile.dart';
//import 'dart:developer' as developer;


class HomePage extends StatefulWidget {




  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  String _dropDownValue="time";

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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                var mpdata=ds.data() as Map;
                List like_user_ids=mpdata["liked_user_ids"]==null?["nothing"]:mpdata["liked_user_ids"];
                bool islike=like_user_ids.contains(cUser.uid);
                return BlogTile(
                uid:mpdata['uid'],
                authorname: mpdata["authorName"],
                imgUrl: mpdata["imgUrl"],
                title:mpdata["title"],
                description: mpdata["desc"],
                time: mpdata["time"],
                documentId: mpdata["documentId"],
                issaved: (cUser.savedBlogs).contains(mpdata["documentId"]),
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
    filldata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      extendBody:true,
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: <Widget>[
        ],
        backgroundColor: Colors.teal,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "B",
            style: TextStyle(fontSize: 40, color: Colors.blue[900]),
          ),
          Text(
            "loggie",
            style: TextStyle(fontSize: 25, color: Colors.blue[50]),
          ),
        ],
        ),

      ),
      body:ListView(
          children:[
            dropdown(),
            blogsStream!=null?blogsList(): Container()]),



      floatingActionButton: Container(
        //padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              child: const Icon(Icons.add,semanticLabel:"add",size:30,color: Colors.black,),

              backgroundColor: Colors.red[400],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget dropdown(){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                    color: Colors.black54, style: BorderStyle.solid, width: 2
                ),
              ),
                child: Row(
                  children: [
                    SizedBox(width:10),
                    Text("Sort by  "),
                    Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),

                      child: DropdownButton(
                        isDense:true,
                        hint: _dropDownValue == null
                            ? Text('Sort By')
                            : Text(
                          _dropDownValue,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                       // isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.black),
                        items: ['time', 'likes_count'].map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          filldata(value:val);
                          setState(
                                () {
                                  _dropDownValue = val;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

            ],
    ),
  );

  }
 void filldata({value:'time'}){
    print(value);
  CrudMethods.getAllData(value).then((result) {
    print("refreshed");
    setState(() {
      blogsStream = result;
    });
});
  }
}
