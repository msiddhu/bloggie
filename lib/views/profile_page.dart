import 'package:country_picker/country_picker.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloggie/services/static_components.dart';

class profilePage extends StatefulWidget {
  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String _selectedCountry,_gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile Page"),),
        body:Container(
          child:Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: 30,),

                Row(
                  children: [
                    SizedBox(width: 30,),
                    ClipOval(child: Image.network(cUser.photoURL)),
                    SizedBox(width:25 ,),
                Column(
                      children: [
                        Text(cUser.displayName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        SizedBox(height: 10,),
                        Text(cUser.email,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),


                      ],
                    )

                  ],
                ),
                SizedBox(height: 30,),

                //under devlopment
                Text("stats pending"),
            Text("Registered :  "+ cUser.registered_date.toDate().toString().substring(0,16),style: TextStyle(fontWeight: FontWeight.bold),),

              ],
            ),
          ),
        )

    );
  }
}