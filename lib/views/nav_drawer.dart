import 'package:bloggie/services/auth.dart';
import 'package:bloggie/services/static_components.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        padding: new EdgeInsets.all(0.0),
        children: <Widget>[
          new UserAccountsDrawerHeader(

            accountName: new Text(cUser.displayName),
            accountEmail: new Text(cUser.email),
            currentAccountPicture: Image.network(cUser.photoURL),

          ),
          new ListTile(
            title: new Text("My Profile"),
            trailing: new Icon(Icons.person),
            onTap: () => {},
          ),
          Divider(),
          ListTile(
            title: new Text("My blogs"),
            trailing: new Icon(Icons.person),
            onTap: () => {},
          ),
          Divider(),
          ListTile(
            title: new Text("Stats"),
            trailing: new Icon(Icons.person),
            onTap: () => {},
          ),

          Divider(),
          // new ListTile(
          //   title: new Text("Close"),
          //   trailing: new Icon(Icons.close),
          //   onTap: () => Navigator.of(context).pop(),
          // ),

          ListTile(
            title: new Text("Settings"),
            trailing: new Icon(Icons.person),
            onTap: () => {},
          ),
          new ListTile(
            title: new Text("Sign Out ",style: TextStyle(fontSize: 25),),
            // trailing: new Icon(Icons.close),
            onTap: () => AuthService().signOut(),
          ),
        ],
      ),
    );
  }


}








