import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'static_components.dart';

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
      'saved_blogs':[],
      'blogs':[],

    });
    print('user created');
  }

  static init() async {

    cUser.userRef = _db.collection('users').doc((await FirebaseAuth.instance.currentUser).uid);

    DocumentSnapshot ds= await cUser.userRef.get();
    if(ds.exists){
      print("exists");
    cUser.email=ds.get('email');
    cUser.registered_date=ds.get('registeredDate');
    cUser.displayName=ds.get('displayName');
    cUser.photoURL=ds.get('photoURL');
    cUser.uid=ds.get('uid');
    cUser.blogs=ds.get('blogs');
    cUser.saved_blogs=ds.get('saved_blogs');
    cUser.ready=true;
    }
    //cUser.blogCollection=FirebaseFirestore.instance.collection('blogs');
    print(cUser.saved_blogs);

    print("user details initiated");
    return true;
  }


  void signOut() {
    _auth.signOut();
    _googleSignIn.signOut();
  }
}

final  AuthService authService = AuthService();
