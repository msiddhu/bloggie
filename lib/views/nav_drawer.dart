import 'package:bloggie/services/auth.dart';
import 'package:bloggie/services/static_components.dart';
import 'package:bloggie/views/profile_page.dart';
import 'package:bloggie/views/settings_page.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'allblogs/tab_bar.dart';

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
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilePage())),
            },
          ),
          Divider(),
          ListTile(
            title: new Text("My Blogs"),
            trailing: new Icon(Icons.person),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlogTabBar())),
            },
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
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settings())),
            },
          ),
          new ListTile(
            title: new Text("Sign Out ",style: TextStyle(fontSize: 25),),
            // trailing: new Icon(Icons.close),
            onTap: () => AuthService.signOut(),
          ),
        ],
      ),
    );
  }


}








