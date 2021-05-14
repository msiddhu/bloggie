import 'package:bloggie/services/like.dart';
import 'package:bloggie/services/save.dart';
import 'package:bloggie/views/blog/blog_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bloggie/services/static_components.dart';


class BlogTile extends StatefulWidget {
  String imgUrl, title, description, authorname, documentId;
  Timestamp time;
  bool isliked,issaved;
  int likecount;
  BlogTile(
      {@required this.imgUrl,
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

  var boxheight = 10.0;
  String like;
  var descheight = 225.0;

  @override
  Widget build(BuildContext context) {
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

              Text(widget.title ?? "Title",
                  style: TextStyle(
                    color: Colors.yellow[800],
                    fontSize: 20,
                  )),

              SizedBox(
                height: boxheight / 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // color: Colors.red,
                  child: Text("~" + widget.authorname,
                      style: TextStyle(
                        color: Colors.blue[600],
                        fontSize: 12,
                      )),
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
                        color: Colors.black54.withOpacity(0.4),
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
                                color: Colors.grey[200],
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
                  child: Text(widget.likecount.toString()+like)):Container(),

              Container(

                child:widget.authorname==cUser.displayName?Container(height:30,child:Text("Created at : "+widget.time.toDate().toString().substring(0,16))):
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),

                      // highlightColor:Colors.pink,
                     color: widget.isliked ? Colors.red[50]:Colors.grey[50],
                      //color:Colors.deepOrange,
                      onPressed: () {
                        widget.isliked?removelike(widget.documentId):addlike(widget.documentId);
                        setState(() => widget.isliked = ! widget.isliked);
                        print(widget.isliked);

                      },
                      child: Icon(widget.isliked?Icons.favorite:Icons.favorite_border,
                        color: Colors.red,
                      ),
                     // label: Text(''),
                      splashColor: Colors.red,
                    ),


                    Divider(),

                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: Colors.grey[50],
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
                      //label: Text(''),
                      splashColor: Colors.lightGreen,
                    ),


                    Divider(),

                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),

                      color: widget.issaved ?Colors.lime[50]: Colors.grey[50],
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
