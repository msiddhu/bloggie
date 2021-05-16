import 'dart:ui';

import 'package:flutter/material.dart';

class cColors{

  static Color appbarcolorlight=Colors.orange;
  static Color appbarcolordark=Colors.orange[800];
  static bool darkmode=false;
  static Color followingtile=Colors.blue[400];
  static Color profilelight=Colors.purple[200];
  static Color profiledark=Colors.purple[800];
  static Color profile_image_border=Colors.indigoAccent;
  static Color authorname=Colors.blue;
  static Color scaffoldBglight=Colors.blue[50];
  static Color scaffoldBgdark=Color.fromRGBO(3, 45, 80, 1);
  // static Color followingtile=Colors.blue[300];



  static Map<int, Color> darkcolorCodes = {
    50: Color.fromRGBO(251,192,45, .1),
    100: Color.fromRGBO(251,192,45, .2),
    200: Color.fromRGBO(251,192,45, .3),
    300: Color.fromRGBO(251,192,45, .4),
    400: Color.fromRGBO(251,192,45, .5),
    500: Color.fromRGBO(251,192,45, .6),
    600: Color.fromRGBO(251,192,45, .7),
    700: Color.fromRGBO(251,192,45, .8),
    800: Color.fromRGBO(251,192,45, .9),
    900: Color.fromRGBO(251,192,45, 1),
  };
// Green color code: FF93cd48
  static MaterialColor darkprimaryswatch= MaterialColor(0xFF93cd48, darkcolorCodes);



  static Map<int, Color> lightcolorCodes = {
    50: Color.fromRGBO(33,150,243, .1),
    100: Color.fromRGBO(33,150,243, .2),
    200: Color.fromRGBO(33,150,243, .3),
    300: Color.fromRGBO(33,150,243, .4),
    400: Color.fromRGBO(33,150,243, .5),
    500: Color.fromRGBO(33,150,243, .6),
    600: Color.fromRGBO(33,150,243, .7),
    700: Color.fromRGBO(33,150,243, .8),
    800: Color.fromRGBO(33,150,243, .9),
    900: Color.fromRGBO(33,150,243, 1),
  };

// Green color code: FF93cd48
  static MaterialColor lightprimaryswatch= MaterialColor(0xFF93cd48, darkcolorCodes);
// white blue

  static ThemeData lighttheme=ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[200],
      ),

    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.yellow[800],
    ),


    appBarTheme: AppBarTheme(
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          headline1: TextStyle(
            color: Colors.blue[800],
            fontSize: 18.0,
          ),
        ),
        color: appbarcolorlight,
      brightness: Brightness.dark,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.deepPurple,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
      ),
        headline1: TextStyle(
          color: Colors.blueAccent,
          fontSize: 18.0,
        )
    ),
    scaffoldBackgroundColor: scaffoldBglight,
    brightness: Brightness.light,
    primarySwatch: lightprimaryswatch,
      errorColor: profilelight
  );




// -----------
  //darktheme
//black yellow
  static ThemeData darktheme=ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.cyan[200],
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white,
      secondary: Colors.blue,
    ),

    appBarTheme: AppBarTheme(

        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          headline1: TextStyle(
            color: Colors.blue[300],
            fontSize: 18.0,
          )

        ),
        color: appbarcolordark,
       brightness: Brightness.dark,

  ),
    cardTheme: CardTheme(
      color: Colors.black87,
    ),
    iconTheme: IconThemeData(
      color: Colors.deepPurple[200],
    ),

    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
        headline1: TextStyle(
          color: Colors.blue[800],
          fontSize: 18.0,
        )
    ),
    scaffoldBackgroundColor: scaffoldBgdark,
    //brightness: Brightness.dark,
    primarySwatch: darkprimaryswatch,
    errorColor: profiledark

  );



}