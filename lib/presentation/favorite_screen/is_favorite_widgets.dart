import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/constants/colors.dart';

Widget inFavorites() => Icon(
  Icons.favorite,
  size: 17.sp,
  color: Colors.red,
);

Widget notInFavorites() => Icon(
  Icons.favorite_border,
  size: 17.sp,
  color: AppColors.secondaryColor,
);