import 'package:bloggie/services/auth.dart';
import 'package:bloggie/utils/utils.dart';
import 'package:bloggie/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/color_components.dart';

import '../main.dart';
import '../views/open_page.dart';

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
      asyncMethod().then((flag) =>
      {
        setState(() {
          print("after initialization");
          initialized = flag;
        })
      }
      );


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