import 'package:bloggie/services/auth.dart';
import 'package:bloggie/utils/static_components.dart';
import 'package:bloggie/views/profile/my_profile.dart';
import 'package:bloggie/views/settings_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contact_us.dart';
import 'info_page.dart';

class NavDrawer extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        padding: new EdgeInsets.all(0.0),
        children: <Widget>[
          new UserAccountsDrawerHeader(

            accountName:Text(cUser.displayName,style: TextStyle(color: Theme.of(context).textTheme.headline6.color),),
            accountEmail: Text(cUser.email,style: TextStyle(color: Theme.of(context).textTheme.headline6.color)),
            currentAccountPicture: CircleAvatar(child:Image.network(cUser.photoURL)),
              decoration: BoxDecoration(
                  //color: Colors.indigo,
                  gradient: LinearGradient(colors: [Theme.of(context).scaffoldBackgroundColor,Colors.blue])),
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
            title: new Text("Settings"),
            trailing: new Icon(Icons.settings,color:Colors.purple),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settings())),
            },
          ),
          Divider(),
          ListTile(
            title: new Text("Contact Us"),
            trailing: new Icon(Icons.auto_stories,color:Colors.pink),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => contactUs())),
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

                Text("About",style:TextStyle(decoration: TextDecoration.underline,color:Colors.blue),),

                // GestureDetector(
                //     child: Text("Contact us",
                //       style:TextStyle(
                //           decoration: TextDecoration.underline,color:Colors.blue),))

              ],
            ),
          ),



        ],
      ),
    );
  }


}








