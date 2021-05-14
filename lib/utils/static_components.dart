import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cUser{
  static var displayName;
  static var uid;
  static var photoURL;
  static var email;
  static var registeredDate;
  static List blogs;
  static List savedBlogs=[];
  static List likedBlogs=[];
  static List following=[];
 // static List commentId=[];
  static DocumentReference userRef;
  static CollectionReference blogCollection;
  static CollectionReference commentsCollection;
  static bool ready=false;
  static Map alldetails(){
    Map mp={
      'displayName':displayName,
      'email':email,
      'uid':uid,
      'photoURL':photoURL,
      'registeredDate':registeredDate,
      'blogs':blogs,
      'savedBlogs':savedBlogs,
      'likedBlogs':likedBlogs,
      'ready':ready,
    };
    return mp;
  }
}

class cColors{
  static Color appbarcolor=Colors.teal;
  static bool darkmode=false;
}