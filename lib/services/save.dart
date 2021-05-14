//save
//unsave
import 'package:cloud_firestore/cloud_firestore.dart';
import 'static_components.dart';

saveblog(String documentID) async{
  cUser.userRef.update({'savedBlogs':FieldValue.arrayUnion([documentID])});
  cUser.savedBlogs.add(documentID);

}
unsaveblog(String documentID) async{
  cUser.userRef.update({'savedBlogs':FieldValue.arrayRemove([documentID])});
  cUser.savedBlogs.remove(documentID);
}