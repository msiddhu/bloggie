import 'package:bloggie/services/comments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                Text("Number of comments: "+snapshot.data.docs.length.toString()),
                ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return commentTile(
                      (ds.data()as Map)["authorname"],
                      (ds.data()as Map)["comment"],
                      (ds.data()as Map)["datetime"],
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
  String authorname,datetime,comment;

  commentTile(
      @required this.authorname,
      @required this.comment,
      @required this.datetime,
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
              child: Text(widget.datetime,
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 12,
                  )),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(child:Text(widget.comment,
                softWrap: true, textAlign: TextAlign.justify)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // color: Colors.red,
              child: Text("@" + widget.authorname,
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 12,
                  )),
            ),
          ),


        ],

      ),
    );
  }
}


