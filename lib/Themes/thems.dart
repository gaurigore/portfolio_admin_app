import 'package:flutter/material.dart';



class Themes {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,



    //primaryColor: Colors.orangeAccent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),

    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    //scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey.shade800,

    ),
    primaryColor: Colors.grey.shade800,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
