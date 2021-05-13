import 'package:bloggie/services/auth.dart';
import 'package:bloggie/services/static_components.dart';
import 'package:bloggie/views/profile_page.dart';
import 'package:bloggie/views/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'allblogs/tab_bar.dart';
import 'info_page.dart';

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
            currentAccountPicture: CircleAvatar(child:Image.network(cUser.photoURL) ),
              decoration: BoxDecoration(
                  //color: Colors.indigo,
                  gradient: LinearGradient(colors: [Colors.blue[900],Colors.lightBlueAccent])),
              //backgroundColor:Colors.amber,

          ),
          new ListTile(
            title: new Text("Profile"),
            trailing: new Icon(Icons.person,color:Colors.indigo),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilePage())),
            },
          ),
          Divider(),
          ListTile(
            title: new Text("My Blogs"),
            trailing: new Icon(Icons.auto_stories,color:Colors.pink),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlogTabBar())),
            },
          ),

          Divider(),

          ListTile(
            title: new Text("Settings"),
            trailing: new Icon(Icons.settings_applications,color:Colors.purple),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settings())),
            },
          ),
          Divider(),
          ListTile(

            title: new Text("Sign Out "),

            trailing: new Icon(Icons.logout,color: Colors.red,),
            // trailing: new Icon(Icons.close),
            onTap: () => {AuthService().signOut(),

            },
          ),
          Divider(),
          SizedBox(height: 60),

          GestureDetector(
            onTap: ()=>{

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InfoPage())),


            },
            child: Column(
              children: [
                Image.asset('assets/blogIcon.png',height: 96,width: 96,),
                Text("Bloggie",textAlign:TextAlign.center,style: TextStyle(fontSize: 24,fontWeight:FontWeight.bold,color:Colors.blue[900]),),

    ],
            ),
          ),



        ],
      ),
    );
  }


}








