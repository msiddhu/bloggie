import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/static_components.dart';
import '../utils/utils.dart';
import '../views/login_page.dart';

class AuthService {
  // Dependencies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  // Shared State for Widgets
  static User user;
  static DocumentReference ref;
  // firebase user
  // custom user data in Firestore
  // constructor
  Future<User> googleSignIn() async {
    // Start

    // Step 1
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Step 2
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    user = (await _auth.signInWithCredential(credential)).user;
    // Step 3
    if(!(await _db.collection('users').doc(user.uid).get()).exists) {
      await createUserData(user);
    }
    await init();
    // Done
    print("signed in " + user.displayName);
    return user;
  }

  Future createUserData(User user) async {
    cUser.userRef = _db.collection('users').doc(user.uid);
    cUser.userRef.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'registeredDate': DateTime.now(),
      'savedBlogs':[],
      'blogs':[],
      'following':[],
    });
    print('user created');
  }

  static init() async {
    if(cUser.ready){return true;}
    cUser.userRef = _db.collection('users').doc((await FirebaseAuth.instance.currentUser).uid);
   // cUser.blogCollection=_db.collection('blogs');
    DocumentSnapshot ds= await cUser.userRef.get();
    if(ds.exists){
      print("exists");
    cUser.email=ds.get('email');
    cUser.registeredDate=ds.get('registeredDate');
    cUser.displayName=ds.get('displayName');
    cUser.photoURL=ds.get('photoURL');
    cUser.uid=ds.get('uid');
    cUser.blogs=ds.get('blogs');
    cUser.following=ds.get('following');
    cUser.savedBlogs=ds.get('savedBlogs');
    cUser.ready=true;
    }
    cUser.blogCollection=FirebaseFirestore.instance.collection('blogs');
    //print(cUser.savedBlogs);

    print("user details initiated");
    return true;
  }
   void deleteUser() async{

    List userblogs=await getuserblogs(cUser.uid);
    for( int i=0;i<userblogs.length;i++){
      cUser.blogCollection.doc(userblogs[i]).delete();
    }
    cUser.userRef.delete();
    User user= _auth.currentUser;
    await user.delete();
    signOut();
  }


  void signOut() {
    cUser.ready=false;
    _googleSignIn.signOut();
    _auth.signOut();

  }
}

