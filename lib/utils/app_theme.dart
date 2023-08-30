import 'package:flutter/material.dart';

class AppTheme{
  //light theme color
  static Color lightbackgroundColor = Colors.grey.shade300;
  static Color appWhite = Colors.white;
  static Color appGrey = Colors.grey;
  static Color appblue = Colors.lightBlue;

  //dark theme color
  static Color darkbackgroundColor = Colors.black;
  static Color appblack = const Color(0xff272727);




  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightbackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: lightbackgroundColor,elevation: 0),
    colorScheme: const ColorScheme.light().copyWith(
      primaryContainer: appWhite,
      primary: Colors.black,
      onPrimary: Colors.black54,
      secondary:  Colors.grey.shade100,
      onSecondary: Colors.black26,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontSize: 24,color: Colors.black),
      displaySmall: TextStyle(fontSize: 18,color: Colors.black54),
    )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkbackgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: darkbackgroundColor,elevation: 0),
    colorScheme:  const ColorScheme.dark().copyWith(
      primaryContainer: appblack,
      primary: Colors.white,
      onPrimary: Colors.white70,
      secondary:  Colors.grey.shade900,
      onSecondary: Colors.white54,
    )

  );

}