import 'package:bloggie/services/auth.dart';
import 'package:bloggie/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/static_components.dart';

import 'open_page.dart';

class connector extends StatefulWidget {
  const connector({Key key}) : super(key: key);

  @override
  _connectorState createState() => _connectorState();
}

class _connectorState extends State<connector> {
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    // TODO: implement initState
   // if (!cUser.ready) {
      asyncMethod().then((flag) =>
      {
        setState(() {
          print("after initialization");
          initialized = flag;
        })
      }
      );
    // //}
    // initialized = true;

  }

  Future<bool> asyncMethod() async {
    bool gh = await AuthService.init();
    return gh;
  }


  @override
  Widget build(BuildContext context) {

    return initialized ? HomePage() : OpenPage();

  }
}