import 'package:flutter/material.dart';

class AppColors{
  static const monoPrimaryColor = Color(0xFFB24BE1);
  static const LinearGradient primaryColor = LinearGradient(
    colors: [
      Color(0xFFAD40E1),
      Color(0xFFE32765),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const scaffoldColorLight = Colors.white;
  static const appBarColorLight = Colors.white;
  static const scaffoldColorDark = Colors.black;
  static const appBarColorDark = Colors.black;

  static const navBarColor = Color(0xFF08143A);
  static const navBarSelectedIconColor = monoPrimaryColor;
  static const navBarNotSelectedIconColor = Colors.white;
  static const navBarSelectedIndicatorColor = monoPrimaryColor;
  static const navBarNotSelectedIndicatorColor = Colors.transparent;
}