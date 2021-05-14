import 'package:bloggie/services/static_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map> getuserdetails(String uid) async{
DocumentSnapshot ds=await FirebaseFirestore.instance.collection('users').doc(uid).get();
Map sd=ds.data() as Map;
print('returning');
print(sd);
return sd;
}
followuser(String follow_uid) async{
  cUser.userRef.update({'following':FieldValue.arrayUnion([follow_uid])});
  cUser.following.add(follow_uid);
return true;
}


unfollowuser(String follow_uid) async{
  cUser.userRef.update({'following':FieldValue.arrayRemove([follow_uid])});
  cUser.following.remove(follow_uid);
  return true;
}


getuserblogs(uid)async{
DocumentSnapshot ds=await FirebaseFirestore.instance.collection('users').doc(uid).get();
List userblogs=(ds.data() as Map)['blogs'];
print(userblogs);
return userblogs;
}
class Utils{

}