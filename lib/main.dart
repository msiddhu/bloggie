import 'package:bloggie/config.dart';
import 'package:bloggie/utils/connector.dart';
import 'package:bloggie/services/auth.dart';
import 'package:bloggie/utils/color_components.dart';

import 'package:bloggie/views/home_page.dart';
import 'package:bloggie/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/open_page.dart';


void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currenttheme.addListener(() {
      print("changes");
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bloggie',
        theme:cColors.lighttheme,
        darkTheme: cColors.darktheme,
        themeMode: currenttheme.currenttheme(),
        home: _getLandingPage(),
    );
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