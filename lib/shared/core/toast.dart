import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast({
  required String? message,
  required Color backgroundColor,
}) {
  Fluttertoast.showToast(
    msg: message!,
    backgroundColor: backgroundColor,
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 5,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    fontSize: 16.sp,
  );
}