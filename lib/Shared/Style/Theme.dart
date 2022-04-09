import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Colors.grey.shade900
ThemeData lightTheme = ThemeData(
   appBarTheme: AppBarTheme(
     color: Colors.white,
     elevation: 0.0,
     titleTextStyle: TextStyle(
       color: Colors.black,
       fontSize: 25,
       fontFamily: "Font1" ,
     ),
     iconTheme: IconThemeData(
       color: Colors.black,
       size: 25
     )
   ) ,
  scaffoldBackgroundColor: Colors.white ,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFfe6f5e),
  ) ,
  textTheme: TextTheme(
    button: TextStyle(
      color:  Color(0xFFfe6f5e),
      fontSize: 15.0,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontFamily: "Font1",
      fontSize: 20,
    ),
    bodyText2: TextStyle(
      color: Colors.black54,
      fontSize: 18,
    ),
    headline1: TextStyle(
      color: Colors.black ,
      fontSize: 10.0,
      overflow: TextOverflow.ellipsis,
    ),

  ),
  accentColor: Color(0xFFfe6f5e),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 20,
    selectedItemColor: Color(0xFFfe6f5e) ,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),

);