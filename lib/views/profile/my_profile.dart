import 'package:bloggie/views/allblogs/all_blogs.dart';
import 'package:bloggie/views/allblogs/following_list.dart';
import 'package:bloggie/views/profile/profile.dart';
import 'package:bloggie/views/profile/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/static_components.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    double icon_size=20;
    double text_size=12;
    Color textcolor=Theme.of(context).textTheme.headline6.color;
    Color iconcolor=Theme.of(context).iconTheme.color;
    return DefaultTabController(
      length:3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: Text("My Profile")),
          body:Column(
            children: [
              Profile(cUser.alldetails()),
              Container(
                height: 60,
                child: AppBar(
                  backgroundColor: Theme.of(context).errorColor,
                  automaticallyImplyLeading: false,
                  flexibleSpace: TabBar(
                    indicatorColor: Colors.lime,
                    indicatorWeight: 5.0,
                    labelColor: Colors.white,
                    labelPadding: EdgeInsets.only(top: 5.0),
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        child:Text('My Blogs',style: TextStyle(fontSize: text_size,color:textcolor),),
                       // text: 'My Blogs',
                        icon: Icon(
                          Icons.auto_stories,
                          color: iconcolor,
                          size: icon_size,
                        ),
                        iconMargin: EdgeInsets.only(bottom: 5.0),
                      ),

                      Tab(
                        child:Text('Saved Blogs',style: TextStyle(fontSize: text_size,color:textcolor),),
                     //   text: 'Saved Blogs',
                        icon: Icon(
                          Icons.collections_bookmark,
                          color: iconcolor,
                          size: icon_size,
                        ),
                        iconMargin: EdgeInsets.only(bottom: 5.0),
                      ),
                      Tab(
                        child:Text('Following',style: TextStyle(fontSize: text_size,color:textcolor),),
                       // text: 'Following',
                        icon: Icon(
                          Icons.wine_bar_rounded,
                          color: iconcolor,
                          size: icon_size,
                        ),
                        iconMargin: EdgeInsets.only(bottom: 5.0),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                  child:TabBarView(
                    children: [
                      AllBlogs(cUser.blogs,false),
                      AllBlogs(cUser.savedBlogs,false),
                      Following(),

                    ],
                  )

              ),
              //Stats(),
            ],
          )

      ),
    );
  }




}