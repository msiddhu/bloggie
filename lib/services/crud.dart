import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/static_components.dart';


class CrudMethods {

  static Future<void> addData(blogData) async {

    var doc=cUser.blogCollection.doc();
    blogData["documentId"]=doc.id;
    doc.set(blogData).catchError((e){
      print("error"+e);
    });
    DocumentSnapshot ds=await cUser.userRef.get();


    if((ds.data() as Map)['blogs']==null){
      cUser.userRef.update({"blogs":[doc.id]});

    }

    else{
      var list=List.from((ds.data()as Map)['blogs']);
      list.add(doc.id);
      cUser.userRef.update({'blogs':list});

    }
    cUser.blogs.add(doc.id);
  }

  static getAllData(String value) async {
    cUser.blogCollection=FirebaseFirestore.instance.collection('blogs');
    var d=FirebaseFirestore.instance.collection('blogs').orderBy(value,descending:true);

    return d.snapshots();
  }

  static Future<Map<String, dynamic>> getBlogData(documentId) async{
    var temp=await cUser.blogCollection.doc(documentId).get();
    Map<String,dynamic> map=temp.data();
    print(map);
    return map;
  }

  static Future<bool> updateData(updatedMap,documentId) async{
    var doc=cUser.blogCollection.doc(documentId);
    doc.update(updatedMap).catchError((e){
      print(e);
    });
    return true;
  }

  static deleteData(documentId) async{
    cUser.blogCollection.doc(documentId).delete();
    DocumentSnapshot ds=await cUser.userRef.get();
    var v=List.from((ds.data()as Map)['blogs']);
    v.remove(documentId);
    cUser.userRef.update({"blogs":v});
    print('deleted '+documentId.toString()+'succesfully');
  }

}
