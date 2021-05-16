import 'package:bloggie/utils/connector.dart';
import 'package:bloggie/services/auth.dart';
import 'package:bloggie/utils/color_components.dart';

import 'package:bloggie/views/home_page.dart';
import 'package:bloggie/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/open_page.dart';


void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bloggie',
        theme: buildThemeData(),
        home: _getLandingPage(),
    );
  }

  ThemeData buildThemeData() {
    if(cColors.darkmode){
      print("dark theme");
      return cColors.darktheme;
    }
    else{
      print("light theme");
      return cColors.lighttheme;
    }
  }

  Widget _getLandingPage() {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          print("homePage");
          return connector();
        }
        else {
          print("loginpage");
          return LoginPage();
        }
      },
    );
  }
}