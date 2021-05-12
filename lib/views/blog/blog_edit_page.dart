import 'package:flutter/cupertino.dart';

class EditBlog extends StatefulWidget {
  String blog_id;
  EditBlog({
    @required this.blog_id,
})

  @override
  _EditBlogState createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  String author, title, desc;
  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
