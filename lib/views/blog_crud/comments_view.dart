import 'package:bloggie/views/profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/comments.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:bloggie/utils/color_components.dart';

class CommentsView extends StatefulWidget {

  String documentId;
  CommentsView({this.documentId});
  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {


  Stream commentsStream;
  @override
  Widget build(BuildContext context) {


    //return Container(child:Text(widget.documentId),)
    return Container(


      child: StreamBuilder<QuerySnapshot>(
        stream: commentsStream,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          else{
            return Column(
              children: [
                Text("Number of comments: "+snapshot.data.docs.length.toString(),style:TextStyle(color:Theme.of(context).textTheme.headline1.color)),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    Map mpdata=ds.data() as Map;
                    return commentTile(
                      mpdata["uid"],
                      mpdata['blogId'],
                      mpdata["authorname"],
                      mpdata["comment"],
                      mpdata["datetime"],
                      mpdata['commentId']
                    );
                  },
                ),
              ],
            );

          }
        },
      ),
    );
  }


  @override
  initState()  {
    super.initState();
    comments.getAlldata(widget.documentId).then((result) {
      setState(() {
        commentsStream = result;
      });
    });
  }
}

class commentTile extends StatefulWidget {
  String authorname,comment,uid,commentId,blogId;
  var datetime;

  commentTile(
      @required this.uid,
      @required this.blogId,
      @required this.authorname,
      @required this.comment,
      @required this.datetime,
      @required this.commentId,
      );

  @override
  _commentTileState createState() => _commentTileState();
}

class _commentTileState extends State<commentTile> {
  @override
  Widget build(BuildContext context) {
    print(widget.authorname);
    print(widget.comment);
    print(widget.datetime);
    double cheight=widget.comment.length>120?150:100;
    print(widget.comment.length);
    print(cheight);
    Color titlecolor=Theme.of(context).textTheme.headline1.color;
    Color textcolor=Theme.of(context).textTheme.headline6.color;
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,

        children:<Widget>[

          Divider(thickness: 1.5,color: Colors.indigo,),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // color: Colors.red,
              child: Text(widget.datetime.toDate().toString().substring(0,10),
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 12,
                  )),
            ),
          ),

          //Container(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          //child:
          Row(
            children: [
              SizedBox(width:20,),
              Flexible(
                child:Text(widget.comment,style: TextStyle(color:textcolor),
                    softWrap: true, textAlign: TextAlign.justify),
              ),
              SizedBox(width:20),
            ],
          ),
          // ),
          widget.uid==cUser.uid?Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap:(){comments.deleteComment(widget.blogId,widget.commentId).then((_){
              String message="Comment deleted";
                SnackBar snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 1),);
                Scaffold.of(context).showSnackBar(snackBar);
                print(message);
              });},
                child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
              // color: Colors.red,
              child: Text("Delete",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 12,
                  )
              )
          ),
            ),
          ):Container(),
          widget.uid!=cUser.uid?Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap:(){
                print("to user profile page");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserProfile(widget.uid)));
                },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                // color: Colors.red,
                child: Text(widget.authorname,
                    style: TextStyle(
                    decoration: TextDecoration.underline,
                      color: cColors.authorname,
                      fontSize: 12,
                    )
                )
              ),
            )
          ):Container(),


        ],

      ),
    );
  }
}

