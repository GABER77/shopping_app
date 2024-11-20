import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/constants/spaces.dart';
import 'boarding_model.dart';

class BoardingItem extends StatelessWidget {
  const BoardingItem({
    super.key,
    required this.model,
  });

  final BoardingModel model;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Image.asset(
            model.image,
            width: 350.w,
            height: 350.h,
          ),
        ),
        Spaces.vSpacingS,
        Text(
          model.title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Spaces.vSpacingM,
        Text(
          model.body,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}