import 'package:cloud_firestore/cloud_firestore.dart';

class cUser{
  static var displayName;
  static var uid;
  static var photoURL;
  static var email;
  static var lastSeen;
  static List blogs;
  static List saved_blogs=[];
  static List liked_blogs=[];
  static List commentId=[];
  static DocumentReference userRef;
  static CollectionReference blogCollection;
  static CollectionReference commentsCollection;
  static bool ready=false;

}

class cColors{
  static bool darkmode=false;
}