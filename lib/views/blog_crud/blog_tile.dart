import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloggie/services/crud.dart';
import 'package:bloggie/services/like.dart';
import 'package:bloggie/services/save.dart';
import 'package:bloggie/views/blog_crud/blog_edit.dart';
import 'package:bloggie/views/blog_crud/blog_view.dart';
import 'package:bloggie/views/profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bloggie/utils/static_components.dart';

import '../home_page.dart';


class BlogTile extends StatefulWidget {
  String imgUrl, title, description, authorname, documentId,uid;
  Timestamp time;
  bool isliked,issaved;
  int likecount;
  BlogTile(
      {@required this.imgUrl,
        @required this.uid,
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
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  var iconsize = 25.0;
  var boxheight = 7.0;
  String like;
  var descheight = 225.0;
  @override
  Widget build(BuildContext context) {

    Color titlecolor=Theme.of(context).textTheme.headline1.color;
    Color textcolor=Theme.of(context).textTheme.headline6.color;
    Color buttoncolor=Theme.of(context).scaffoldBackgroundColor;
    like=(widget.likecount==1)?" like":" likes";
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailblog(documentId: widget.documentId))
        );
      },
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 5),
        margin: EdgeInsets.only(bottom: 12.5),
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10.0,
          //color: Colors.grey,
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: Colors.blueGrey, width: 5),
            borderRadius: BorderRadius.circular(30.0),
          ),

          child: Column(
            children: <Widget>[
              SizedBox(
                height: boxheight,
              ),

              SizedBox(width:MediaQuery.of(context).size.width*(2.5/3),
                child: AutoSizeText(widget.title ?? "Title",
                    minFontSize: 15,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: titlecolor,
                     fontSize: 20,
                    )),
              ),

              SizedBox(
                height: boxheight / 10,
              ),
              widget.uid==cUser.uid?
              Container(
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:[
                     // SizedBox(width: 20,),
                      RaisedButton(onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EditBlog(blog_id:widget.documentId)));

                      },
                          color:Colors.green[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                             // side: BorderSide(color: Colors.green,width: 2.5)
                          ),
                          elevation: 5.0,

                          child:Text("Edit",style: TextStyle(color:textcolor),)),
                  //    new Spacer(),
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                             // side: BorderSide(color: Colors.red,width: 2.5)
                          ),
                          elevation: 5.0,
                          color:Colors.red[400],
                          onPressed: () {
                            CrudMethods.deleteData(widget.documentId);
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePage()));

                          },child:Text("Delete",style: TextStyle(color:textcolor),)),

                    ]
                )
              ) :Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.red,
                  child: GestureDetector(
                    onTap:(){
                      print("to user profile page");
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

              Stack(
                children: <Widget>[
                  Container(
                    height: descheight,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      //borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          imageUrl: widget.imgUrl,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/background.png"),
                          fit: BoxFit.cover),
                      // child:getImg(widget.imgUrl),

                    ),
                  ),
                  Container(
                    height: descheight,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                       // borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                      height: descheight * (2 / 3),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.description,
                              style: TextStyle(
                                color:textcolor,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 10),
                        ],
                      )),
                ],
              ),
              //Divider(),
              SizedBox(
                height: boxheight,
              ),

              widget.likecount>0?Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(25,0, 0,0),
                  child: Text(widget.likecount.toString()+like,style: TextStyle(color:textcolor),)):Container(),

              Container(

                child:widget.uid==cUser.uid?Container(height:30,child:Text("Created at : "+widget.time.toDate().toString().substring(0,10),style: TextStyle(color:textcolor),)):
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: buttoncolor,
                      // highlightColor:Colors.pink,
                    // color: widget.isliked ? Colors.red[50]:Colors.grey[50],
                      //color:Colors.deepOrange,
                      onPressed: () {
                        widget.isliked?removelike(widget.documentId):addlike(widget.documentId);
                        setState(() => widget.isliked = ! widget.isliked);
                        print(widget.isliked);

                      },
                      child: Icon(widget.isliked?Icons.favorite:Icons.favorite_border,
                        color: Colors.red,
                      ),
                      splashColor: Colors.red,
                    ),


                    Divider(),

                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: buttoncolor,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    detailblog(documentId: widget.documentId))
                        );
                      },
                      child: Icon(Icons.add_comment_outlined,
                        color: Colors.green[500],
                      ),

                      splashColor: Colors.lightGreen,
                    ),

                    Divider(),
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: buttoncolor,
                     // color: widget.issaved ?Colors.lime[50]:null,
                      onPressed: () async {
                        print(cUser.savedBlogs);
                        await widget.issaved ? unsaveblog(widget.documentId):saveblog(widget.documentId);
                        setState(() => widget.issaved = !widget.issaved);
                      },

                      child: widget.issaved?Icon(Icons.bookmark,color: Colors.lime,):Icon(Icons.bookmark_border,),
                      //label: widget.issaved?Text('Saved'):Text('Save'),
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
      ),
    );
  }

  getImg(String imgUrl) {
    try {
      Image img;
      img=Image.network(imgUrl);
      print(imgUrl);
      return img;
    }catch (exception){
      return Image.asset("assets/background.png");
    }
  }
}
