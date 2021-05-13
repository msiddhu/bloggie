import 'package:bloggie/connector.dart';
import 'package:bloggie/services/auth.dart';
import 'package:bloggie/services/static_components.dart';

import 'package:bloggie/views/home_page.dart';
import 'package:bloggie/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'open_page.dart';


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
      return ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange
      );
    }
    else{
      return ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
      );
    }
  }

  Widget _getLandingPage() {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          print("homePage");
          // authService.init();
          // return HomePage();

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