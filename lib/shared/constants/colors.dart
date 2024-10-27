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
  static const navBarColor = Colors.black;
  static const navBarSelectedIconColor = Colors.black;
  static const navBarNotSelectedIconColor = Colors.white;
  static const navBarSelectedCircleColor = monoPrimaryColor;
  static const navBarNotSelectedCircleColor = Colors.transparent;
}
