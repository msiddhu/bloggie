import 'package:bloggie/utils/color_components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactus/contactus.dart';

class contactUs extends StatelessWidget {
  const contactUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Contact Us"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ContactUs(
          logo: AssetImage('assets/blogIcon.png'),
          email: 'msiddhu45@gmail.com',
          companyName: 'Bloggie',
          githubUserName: 'msiddhu',
      //    linkedinURL: 'https://www.linkedin.com/in/msiddhu/',
          taglineColor: cColors.scaffoldBgdark,
          companyColor: cColors.scaffoldBgdark,
          cardColor: Colors.blue[400],
          textColor: cColors.scaffoldBgdark,
        ),
      ),


    );
  }
}
