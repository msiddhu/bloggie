import 'package:bloggie/utils/color_components.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloggie/config.dart';

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


Future<int> getlikescountofuser(uid) async {
  List userblogs=await getuserblogs(uid);
print(userblogs);
int count=0;
  for(int i=0;i<userblogs.length;i++) {
    var ds = await FirebaseFirestore.instance.collection('blogs').doc(userblogs[i]).get();
    print(ds.exists);
    Map mp=(ds.data() as Map);
    print(mp);
    count=count+mp['likesCount'];
  }
  return count;
}


Future<int> getblogscount(uid) async {
  List userblogs=await getuserblogs(uid);
  return userblogs.length;
}

String unifiedDate(date){

}
 void setdarkmode(darkmode)  async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('darkmode', darkmode);
}






class MyTheme with ChangeNotifier {

  static bool _isdark=true;
  MyTheme(){
    if(prefs.containsKey('darkmode')){
      _isdark=prefs.getBool('darkmode');
    }
    else{
      prefs.setBool('darkmode',_isdark);
    }
  }


  ThemeMode currenttheme(){
   return  _isdark?ThemeMode.dark:ThemeMode.light;
    print(_isdark);

  }
  void switchtheme(){
    print('switchtheme called');
    _isdark=!_isdark;
    prefs.setBool('darkmode',_isdark);
    print(_isdark);
    notifyListeners();
  }
  }



