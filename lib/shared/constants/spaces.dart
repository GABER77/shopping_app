import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spaces {
  static const double paddingUnit = 16.0;
  static const double paddingUnitM = 12.0;
  static const double paddingUnitS = 8.0;
  static const double marginUnit = 16.0;
  static const double borderUnit = 32.0;
  static const double borderUnitS = 8.0;
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  static const EdgeInsetsGeometry padding = EdgeInsets.all(paddingUnit);
  static const EdgeInsetsGeometry paddingM = EdgeInsets.all(paddingUnitM);
  static const EdgeInsetsGeometry paddingS = EdgeInsets.all(paddingUnitS);
  static const EdgeInsetsGeometry paddingV =
  EdgeInsets.symmetric(vertical: 4.0);
  static const EdgeInsetsGeometry paddingH =
  EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsetsGeometry paddingHL =
  EdgeInsets.symmetric(horizontal: 96.0);
  static const EdgeInsetsGeometry margin = EdgeInsets.all(marginUnit);
  static const EdgeInsetsGeometry zero = EdgeInsets.zero;

  static const BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(borderUnit),
  );
  static const BorderRadius borderRadiusS = BorderRadius.all(
    Radius.circular(borderUnitS),
  );

  static const RoundedRectangleBorder roundBorder =
  RoundedRectangleBorder(borderRadius: borderRadius);
  static const RoundedRectangleBorder roundBorderS =
  RoundedRectangleBorder(borderRadius: borderRadiusS);

  static  SizedBox vSpacingS = SizedBox(height: 4.0.h);
  static  SizedBox vSpacingM = SizedBox(height: 16.0.h);
  static  SizedBox vSpacingL = SizedBox(height: 32.0.h);
  static  SizedBox vSpacingXL = SizedBox(height: 40.0.h);
  static  SizedBox hSpacingS = SizedBox(width: 4.0.w);
  static  SizedBox hSpacingM = SizedBox(width: 8.0.w);
  static  SizedBox hSpacingL = SizedBox(width: 16.0.w);
  static  SizedBox hSpacingXL = SizedBox(width: 22.0.w);
}