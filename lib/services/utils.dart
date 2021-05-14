import 'package:bloggie/services/static_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map> getuserdetails(String uid) async{
DocumentSnapshot ds=await FirebaseFirestore.instance.collection('users').doc(uid).get();
Map sd=ds.data() as Map;
print('returning');
print(sd);
return sd;
}
Future<bool> followuser(String uid) async{

return true;
}


Future<bool> unfollowuser(String uid) async{
  return true;
}