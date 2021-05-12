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
                SizedBox(height: 40,),
                cUser.photoURL==null?Text("Loading\nImage"):Image.network(cUser.photoURL),
                SizedBox(height: 30,),
                Text("Name: "+cUser.displayName??"loading",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Text("Email:  "+cUser.email??"loading",style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                //under devlopment
                Text("Country:"),
                RaisedButton(
                    child: Text("select country"),
                    onPressed: (){
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          setState(() {
                            _selectedCountry=country.name;
                            print('Select country: ${country.name}');
                          });

                        },
                      );

                    }),
                Text("Gender :"),
                CustomRadioButton(
                  elevation: 0,
                  absoluteZeroSpacing: true,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: [
                    'Male',
                    'Female'
                  ],
                  buttonValues: [
                    "Male",
                    "Female",
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 16)),
                  radioButtonValue: (value) {
                    _gender=value;
                    print(_gender);
                  },
                  selectedColor: Theme.of(context).accentColor,
                ),


                RaisedButton(
                    child: Text("Save"),
                    onPressed: (){})



              ],
            ),
          ),
        )

    );
  }
}