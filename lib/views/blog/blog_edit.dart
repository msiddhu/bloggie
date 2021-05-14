import 'dart:io';
import 'dart:ui';
import 'package:bloggie/services/static_components.dart';
import 'package:bloggie/services/crud.dart';
import 'package:bloggie/views/blog/blog_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';


class EditBlog extends StatefulWidget {
  String blog_id;
  EditBlog({
    @required this.blog_id,
});

  @override
  _EditBlogState createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  //String author, title, desc;
  bool _isLoading = true;
  bool _isImageChanged=false;
  File _image;
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final  title_controller= TextEditingController();
  final desc_controller = TextEditingController();
  var imgUrl=null;

  @override
  void initState() {
    // TODO: implement initState
    getBlog(widget.blog_id).then((mpdata){
      title_controller.text=mpdata['title'];
      desc_controller.text=mpdata['desc'];
      imgUrl=mpdata["imgUrl"];
      setState(() {
        _isLoading=false;
      });
    }

      );
    super.initState();
  }
  void showSnackBar() {
    final snackBarContent = SnackBar(
      content: Text("yay! posted"),
      duration: Duration(seconds:2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBarContent);
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {

        _image = File(pickedFile.path);
        _isImageChanged=true;
      }
      else
        {
        print('No image selected.');
      }
    });
  }



  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    title_controller.dispose();
    desc_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "Edit",
            style: TextStyle(fontSize: 20, color: Colors.yellow[900]),
          ),
          Text(
            "blog",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ]),
        actions: <Widget>[],
      ),
        body: _isLoading
            ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ):Container(
            margin:EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(

                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: TextField(
                        decoration: InputDecoration(
                          focusColor: Colors.green,
                          hintText: "Title of blog",
                          fillColor: Colors.blue,
                          border: OutlineInputBorder(),
                          labelText: "Title",
                        ),
                        controller: title_controller,
                        maxLength: 50,
                        minLines: 1,
                        maxLines: 2,
                        
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        focusColor: Colors.red,
                        hintText: "Write the description",
                        fillColor: Colors.blue,
                        border: OutlineInputBorder(),
                        labelText: "Description",
                        labelStyle: TextStyle(
                            letterSpacing: 0.5,
                            fontStyle: FontStyle.italic)
                    ),
                    controller: desc_controller,
                    autocorrect: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    minLines: 5,
                    maxLength: 250,

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: _isImageChanged?
                                Image.file(_image, fit: BoxFit.cover)
                                    :Image.network(imgUrl,fit: BoxFit.cover),
                            )
                        ),

                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blue[900])),
                          elevation: 10,
                          child: Text("Change picture"),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ],
                    )
                      ,
                  ),
                ],
              ),
            )
        ),
      floatingActionButton: FloatingActionButton.extended(

        splashColor: Colors.yellow[800],
        focusColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
            side: BorderSide(color: Colors.blue[900])),
        onPressed: () {
          if(desc_controller.text!=null&&title_controller.text!=null)
          {
            print("yes checked blog");
            updateBlog();
          }
          else
            {
            showAlertDialog(context,"Fill all the fields \n(Title and Description)").showDialog();
          }
          // showAlertDialog(context).showDialog();

        },
        label: Text(
          'Save',
          style: TextStyle(fontSize: 18),
        ),
      ),

    );
  }

  Future<Map> getBlog(blog_id) async{
    Map<String,dynamic> mpdata=await CrudMethods.getData(blog_id);
    return mpdata;
  }

  Future<bool> updateBlog() async{
    setState(() {
      _isLoading = true;
    });
    Map map=await CrudMethods.getData(widget.blog_id);
    map['title']=title_controller.text;
    map['desc']=desc_controller.text;
    map['updated_time']=DateTime.now();
    if(_isImageChanged){
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("bloggieimages")
          .child("${randomAlphaNumeric(10)}.jpg");

      final UploadTask taskSnapshot = firebaseStorageRef.putFile(_image);
      imgUrl = await (await taskSnapshot).ref.getDownloadURL();
      map['imgUrl']=imgUrl;

    }
print(map);
    CrudMethods.updateData(map,widget.blog_id).then((flag){

      _isLoading=!flag;
      print("is is done");
      //showSnackBar();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => detailblog(documentId: widget.blog_id))
      );
    });
  }



  // Future<bool> uploadBlog() async {
  //   var downloadUrl;
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (_image != null) {
  //     Reference firebaseStorageRef = FirebaseStorage.instance
  //         .ref()
  //         .child("bloggieimages")
  //         .child("${randomAlphaNumeric(10)}.jpg");
  //
  //     final UploadTask taskSnapshot = firebaseStorageRef.putFile(_image);
  //     downloadUrl = await (await taskSnapshot).ref.getDownloadURL();
  //   }
  //
  //   else {
  //     downloadUrl=cUser.photoURL;
  //   }
  //   print("this is the downloadURL" + downloadUrl);
  //   Map<String, dynamic> blogMap = {
  //     "imgUrl": downloadUrl,
  //     "authorName": cUser.displayName,
  //     "title": title,
  //     "desc": desc,
  //     "liked_user_ids":[],
  //     "time":DateTime.now().toString(),
  //     "likes_count":0,
  //     "commentIDs":[],
  //   };
  //   print(blogMap);
  //   CrudMethods.addData(blogMap).then((result) {
  //
  //     _isLoading=false;
  //     //showSnackBar();
  //     Navigator.pop(context);
  //
  //   });
  // }

  showAlertDialog(BuildContext context,String message) {

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
