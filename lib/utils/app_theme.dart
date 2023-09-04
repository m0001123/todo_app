import 'package:flutter/material.dart';

class AppTheme{
  //light theme color
  static Color lightbackgroundColor =  Color(0xFFE3E3F8);
  static Color appWhite = Colors.white;
  static Color appyellow = Color(0xFFF89A3B);
  static Color appblue = Color(0xFF8686F8);

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
      secondary:  Color(0xFFF1F1F6),
      onSecondary: appblue,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontSize: 24,color: Colors.black),
      displaySmall: TextStyle(fontSize: 18,color: Colors.black54),
    )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF272744),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF272744),elevation: 0),
    colorScheme:  const ColorScheme.dark().copyWith(
      primaryContainer: appblack,
      primary: Colors.white,
      onPrimary: Colors.white70,
      secondary:  Color(0xFF39395E),
      onSecondary: appyellow,
    ),

  );

}