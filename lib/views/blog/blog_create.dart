import 'dart:io';
import 'dart:ui';
import 'package:bloggie/services/static_components.dart';
import 'package:bloggie/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String author, title, desc;
  bool _isLoading = false;
  File _image;
  final picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Text(
            "Write ",
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
      )
          : Container(
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
                      maxLength: 50,
                      minLines: 1,
                      maxLines: 2,
                      onChanged: (val) {
                        title = val;
                      },
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
                          letterSpacing: 0.5, fontStyle: FontStyle.italic)),
                  autocorrect: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  minLines: 5,
                  maxLength: 250,
                  onChanged: (val) {
                    desc = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: _image != null
                      ? Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(_image, fit: BoxFit.cover)))
                      : RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.blue[900])),
                    elevation: 10,
                    child: Text("upload picture "),
                    onPressed: () {
                      getImage();
                    },
                  ),
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
          if(title!=null&&desc!=null){
            print("yes checked blog");
            uploadBlog();
          }
          else{
            showAlertDialog(context,"Fill all the fields \n(Title and Description)").showDialog();
          }
          // showAlertDialog(context).showDialog();

        },
        label: Text(
          'Post',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }


  Future<bool> uploadBlog() async {
    var downloadUrl;
    setState(() {
      _isLoading = true;
    });
    if (_image != null) {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("bloggieimages")
          .child("${randomAlphaNumeric(10)}.jpg");

      final UploadTask taskSnapshot = firebaseStorageRef.putFile(_image);
      downloadUrl = await (await taskSnapshot).ref.getDownloadURL();
    }

    else {
      downloadUrl=cUser.photoURL;
    }
    print("this is the downloadURL" + downloadUrl);
    Map<String, dynamic> blogMap = {
      "imgUrl": downloadUrl,
      "uid":cUser.uid,
      "authorName": cUser.displayName,
      "title": title,
      "desc": desc,
      "liked_user_ids":[],
      "time":DateTime.now(),
      "likes_count":0,
      "commentIDs":[],
    };
    print(blogMap);
    CrudMethods.addData(blogMap).then((result) {
      _isLoading=false;
      //showSnackBar();
      Navigator.pop(context);

    });
  }


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