import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/shared/constants/colors.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.scaffoldColorLight,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.monoPrimaryColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.monoPrimaryColor,
    selectionHandleColor: AppColors.monoPrimaryColor,
    selectionColor: AppColors.monoPrimaryColor,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.appBarColorLight,
    titleTextStyle: TextStyle(
      fontSize: 18.sp,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 25.sp,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.monoPrimaryColor,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.scaffoldColorDark,
  colorSchemeSeed: Colors.white,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.monoPrimaryColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.monoPrimaryColor,
    selectionHandleColor: AppColors.monoPrimaryColor,
    selectionColor: AppColors.monoPrimaryColor,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.appBarColorDark,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 18.sp,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 25.sp,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    backgroundColor: AppColors.monoPrimaryColor,
  ),
);