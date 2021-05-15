import 'package:bloggie/utils/static_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


Future<List> getuserblogs(uid)  async{
DocumentSnapshot ds=await FirebaseFirestore.instance.collection('users').doc(uid).get();
List userblogs=(ds.data() as Map)['blogs'];
print(userblogs);
return userblogs;
}


Future<int> getlikescountofuser(uid)async{
  List userblogs=await getuserblogs(uid);
  int count=0;
  for(int i=0;i<userblogs.length;i++) {
    var ds = await cUser.blogCollection.doc(userblogs[i]).get();
    Map mp=ds.data() as Map;
    count=count+mp['likes_count'];
  }
  return count;
}


Future<int> getblogscount(uid) async {
  List userblogs=await getuserblogs(uid);
  return userblogs.length;
}


class Utils{

}


