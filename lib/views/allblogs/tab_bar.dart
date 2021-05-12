import 'package:bloggie/views/allblogs/my_blogs_page.dart';
import 'package:bloggie/views/allblogs/saved_blogs_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return DefaultTabController(
      length:2,
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
                  Icons.bookmarks,
                  color: Colors.white,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0),
              ),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            MyBlogs(),
            SavedBlogs(),
          ],
        ),


      ),
    );
  }



}
