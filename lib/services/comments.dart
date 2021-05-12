import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'static_components.dart';
//set Comment
//get  all comment


class commentMethods {

  getAlldata(String documentId)async{
    print("this is get all data");
    return cUser.blogCollection.doc(documentId).collection("comments").snapshots();
  }

  deleteComment(String commentId) {

  }

  Future<bool> addComment(String documentId, String comment) async {
    Map<String, dynamic> mp;
    var date=DateTime.now();
    String acdate=date.day.toString()+"/"+date.month.toString()+"/"+(date.year-2000).toString()+" "+date.hour.toString()+":"+date.minute.toString();
    mp = {
      "authorname":cUser.displayName,
      "uid": cUser.uid,
      "comment": comment,
      "datetime": acdate,
      //"blogId":documentId,
    };
    var commentdoc = cUser.blogCollection.doc(documentId)
        .collection("comments")
        .doc();

    commentdoc.set(mp).catchError((e) {
      print("error" + e);
      return false;
    });
    return true;
  }
}

final commentMethods comments=new commentMethods();