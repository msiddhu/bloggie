import 'package:cloud_firestore/cloud_firestore.dart';
import 'static_components.dart';


//add like
//remove like

addlike(String documentID) async {
  await cUser.blogCollection.doc(documentID).update({"likes_count":FieldValue.increment(1),"liked_user_ids":FieldValue.arrayUnion([cUser.uid])});
  cUser.liked_blogs.add(documentID);

}

removelike(String documentID) async{
  await cUser.blogCollection.doc(documentID).update({"likes_count":FieldValue.increment(-1),"liked_user_ids":FieldValue.arrayRemove([cUser.uid])});
  cUser.liked_blogs.add(documentID);
}