import 'package:bloggie/utils/static_components.dart';

class commentMethods {

  getAlldata(String documentId)async{
    print("this is get all data comments");
    return cUser.blogCollection.doc(documentId).collection("comments").snapshots();
  }

  Future<bool> deleteComment(String documentId,String commentId) async {

    cUser.blogCollection.doc(documentId)
        .collection("comments")
        .doc(commentId).delete().then((_){
          print("comment deleted");return true;})
        .onError((error, stackTrace)
    {print(error);});

  }

  Future<bool> addComment(String documentId, String comment) async {
    Map<String, dynamic> mp;
    var date=DateTime.now();
    //String acdate=date.day.toString()+"/"+date.month.toString()+"/"+(date.year-2000).toString()+" "+date.hour.toString()+":"+date.minute.toString();
    var commentdoc = cUser.blogCollection.doc(documentId)
        .collection("comments")
        .doc();
    mp = {
      "authorname":cUser.displayName,
      "uid": cUser.uid,
      "comment": comment,
      "datetime": date,
      "blogId":documentId,
      "commentId":commentdoc.id,
    };


    commentdoc.set(mp).catchError((e) {
      print("error" + e);
      return false;
    });
    return true;
  }
}

final commentMethods comments=new commentMethods();