
import 'package:bloggie/views/allblogs/all_blogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/utils/static_components.dart';
import 'following_list.dart';

class BlogTabBar extends StatefulWidget {
  const BlogTabBar({Key key}) : super(key: key);

  @override
  _BlogTabBarState createState() => _BlogTabBarState();
}

class _BlogTabBarState extends State<BlogTabBar> {


  @override
  void initState(){
    super.initState();
    debugPrint('current: Account: initState() called!');
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print(cUser.blogs);
    print('saved blogs');
    print(cUser.savedBlogs);
    return DefaultTabController(
      length:3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title:Text("All blogs"),
          bottom: TabBar(
            indicatorColor: Colors.lime,
            indicatorWeight: 5.0,
            labelColor: Colors.white,
            labelPadding: EdgeInsets.only(top: 10.0),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'My Blogs',
                icon: Icon(
                  Icons.auto_stories,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
              //child: Image.asset('images/android.png'),

              Tab(
                text: 'Saved Blogs',
                icon: Icon(
                  Icons.collections_bookmark,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),
              Tab(
                text: 'Following',
                icon: Icon(
                  Icons.wine_bar_rounded,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: [

           // MyBlogs(),

            AllBlogs(cUser.blogs,false),
            AllBlogs(cUser.savedBlogs,false),
            Following(),

          ],
        ),


      ),
    );
  }



}
