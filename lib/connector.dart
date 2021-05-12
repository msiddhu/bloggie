import 'package:bloggie/services/auth.dart';
import 'package:bloggie/views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class connector extends StatefulWidget {
  const connector({Key key}) : super(key: key);

  @override
  _connectorState createState() => _connectorState();
}

class _connectorState extends State<connector> {
  bool initialized=false;

  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    asyncMethod().then((flag) => {
      setState(() {
    print("after initialization");
    initialized=flag;
    })
    }
    );
  }

  Future<bool> asyncMethod() async{
   return await AuthService.init();
  }
  @override
  Widget build(BuildContext context) {
    return initialized?HomePage():Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
