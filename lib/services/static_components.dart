import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cUser{
  static var displayName;
  static var uid;
  static var photoURL;
  static var email;
  static var registered_date;
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
  static Color appbarcolor=Colors.teal;
  static bool darkmode=false;
}