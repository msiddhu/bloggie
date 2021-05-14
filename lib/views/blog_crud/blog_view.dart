import 'package:bloggie/services/comments.dart';
import 'package:bloggie/services/crud.dart';
import 'package:bloggie/services/like.dart';
import 'package:bloggie/services/save.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:bloggie/views/blog_crud/blog_edit.dart';
import 'package:bloggie/views/profile/user_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'comments_view.dart';





class detailblog extends StatefulWidget {
  final String documentId;

  const detailblog({@required this.documentId});
  @override
  _detailblogState createState() => _detailblogState();
}

class _detailblogState extends State<detailblog> {
  Map<String, dynamic> data;
  List like_user_ids;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CrudMethods.getBlogData(widget.documentId).then((mp){
      setState(() {
        data=mp;
        like_user_ids=data["liked_user_ids"];
      });
    });

  }
  @override
  Widget build(BuildContext context) {

    return data==null?Container():Scaffold(
      appBar: AppBar(
        title:
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "Detailed ",
            style: TextStyle(fontSize: 20, color: Colors.yellow[900]),
          ),
          Text(
            "View",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ]
        ),
        actions: <Widget>[],
      ),
      body: data==null?Container():
      Container(
        // margin:EdgeInsets.symmetric(horizontal: 5),
        margin:EdgeInsets.all(5),

        //padding: EdgeInsets.symmetric(horizontal: 10),
        decoration:BoxDecoration( border:Border.all(color: Colors.indigo,width: 2),borderRadius: BorderRadius.circular(15.0)),
        child: ListView(
            children:<Widget>[
              BlogViewTile(
                imgUrl:data["imgUrl"],
                uid:data['uid'],
                authorname: data["authorName"],
                title: data["title"],
                description: data["desc"],
                issaved:(cUser.savedBlogs).contains(data["documentId"]) ,
                time:data["time"],
                documentId: data["documentId"],
                likecount: data["likes_count"],
                isliked: like_user_ids.contains(cUser.uid),
              ),
              SizedBox(height: 10,),
              WriteComment(documentId:widget.documentId),
              SizedBox(height: 10,),
              CommentsView(documentId:widget.documentId),
            ]

        ),
      ),
    );

  }
}

class WriteComment extends StatelessWidget {
  String comment;
  String documentId;
  String message;
  var txt = TextEditingController();


  WriteComment(
      {
        @required this.documentId,
      }
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: txt,
              decoration: InputDecoration(
                hintText: 'Write Comment',
                labelText: 'Comment',
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),

              ),
            ),
          ),

          FloatingActionButton(
              mini: true,
              backgroundColor: Colors.deepOrangeAccent,
              child: Icon(Icons.arrow_forward),

              onPressed:() async {
                comment=txt.text;
                txt.clear();
                if(comment.isEmpty){
                  showAlertDialog(context,"The comment can't be empty");
                }
                else{
                  comments.addComment(documentId, comment).then((value){
                    message=value?"Comment posted":"Comment not posted";
                    SnackBar snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 1),);
                    Scaffold.of(context).showSnackBar(snackBar);
                    print(message);
                  });
                  FocusScope.of(context).requestFocus(FocusNode());//keyboard dismiss
                }
              }
          ),




        ],
      ),


    );
  }

   showAlertDialog(BuildContext context,String message)
   {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}




class BlogViewTile extends StatefulWidget {
  String imgUrl, title,uid, description, authorname, documentId;
  Timestamp time;
  bool isliked,issaved;
  int likecount;

  BlogViewTile(
      {
        @required this.uid,
        @required this.imgUrl,
        @required this.authorname,
        @required this.description,
        @required this.title,
        @required this.time,
        @required this.documentId,
        @required this.isliked,
        @required this.likecount,
        @required this.issaved,
      });


  @override
  _BlogViewTileState createState() => _BlogViewTileState();
}

class _BlogViewTileState extends State<BlogViewTile> {
  var iconsize = 25.0;
  var boxheight = 10.0;
  var descheight = 225.0;
  String like;





  @override
  Widget build(BuildContext context) {
    like=(widget.likecount==1)?" like":" likes";
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: boxheight,
            ),

            //Text(widget.title ?? "Title",
            Text(widget.title,
                style: TextStyle(
                  color: Colors.yellow[800],
                  fontSize: 25,
                )),
            Container(
              child:widget.uid==cUser.uid?
              Row(
                  children:[
                    SizedBox(width: 20,),
                    RaisedButton(onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => EditBlog(blog_id:widget.documentId)));


                    },
                        color:Colors.greenAccent[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.green,width: 2.5)
                        ),
                        elevation: 5.0,

                        child:Text("edit")),
                    new Spacer(),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red,width: 2.5)
                        ),
                        elevation: 5.0,
                        color:Colors.pink[300],
                        onPressed: () {
                          CrudMethods.deleteData(widget.documentId);
                          Navigator.pop(context);

                        },child:Text("delete",style: TextStyle(color: Colors.white),)),
                    SizedBox(width: 20,),
                  ]
              ):
              SizedBox(
                height: boxheight / 10,
              ),
            ),
            SizedBox(
              height: boxheight / 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                // color: Colors.red,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserProfile(widget.uid)));
                  },
                  child: Text("~" + widget.authorname,
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 12,
                      )),
                ),
              ),
            ),

            SizedBox(
              height: boxheight,
            ),

            Column(
              children: <Widget>[
                Container(
                  height: descheight,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        imageUrl: widget.imgUrl,
                        placeholder: (context, url) =>
                            Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: boxheight*3/2,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,

                  child:Text(widget.description,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 10),
                ),
              ],
            ),
            //Divider(),
            SizedBox(
              height: boxheight,
            ),
            widget.likecount>0?Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(25,0, 0,0),
                child: Text(widget.likecount.toString()+like)):Container(),

            Container(
              child:widget.authorname==cUser.displayName?SizedBox(height:5):
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton.icon(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),

                    // highlightColor:Colors.pink,
                    color: widget.isliked ? Colors.red[50]:Colors.grey[50],
                    onPressed: () {
                      if(widget.isliked){
                        removelike(widget.documentId);
                        widget.likecount-=1;
                      }else{
                        widget.likecount+=1;
                        addlike(widget.documentId);
                      }
                      //  widget.isliked?removelike(widget.documentId):addlike(widget.documentId);
                      setState(() {
                        widget.likecount;
                        widget.isliked = ! widget.isliked;});
                      print(widget.isliked);
                      print("yooo broooooo");
                    },
                    icon: Icon(Icons.favorite,
                      color:  widget.isliked ? Colors.red:Colors.grey,
                    ),
                    label: Text('Like'),
                    splashColor: Colors.red,
                  ),
                  Divider(),

                  RaisedButton.icon(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),

                    color: widget.issaved ?Colors.lime[50]: Colors.grey[50],
                    onPressed: () async {
                      print(cUser.savedBlogs);
                      await widget.issaved ? unsaveblog(widget.documentId):saveblog(widget.documentId);
                      setState(() => widget.issaved = !widget.issaved);
                    },

                    icon: widget.issaved?Icon(Icons.bookmark,color: Colors.lime,):Icon(Icons.bookmark_border,),
                    label: widget.issaved?Text('Saved'):Text('Save'),
                    splashColor: Colors.lime,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: boxheight,
            ),
          ],
        ),
      ),
    );
  }
}


