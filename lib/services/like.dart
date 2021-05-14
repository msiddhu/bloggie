import 'package:cloud_firestore/cloud_firestore.dart';
import 'static_components.dart';


//add like
//remove like

void addlike(String documentID) async {
  await cUser.blogCollection.doc(documentID).update({"likesCount":FieldValue.increment(1),"liked_user_ids":FieldValue.arrayUnion([cUser.uid])});
  cUser.likedBlogs.add(documentID);

}

void removelike(String documentID) async{
  await cUser.blogCollection.doc(documentID).update({"likesCount":FieldValue.increment(-1),"liked_user_ids":FieldValue.arrayRemove([cUser.uid])});
  cUser.likedBlogs.add(documentID);
}

 Future<int> get_all_likes(String uid) async{
  
}