import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/shared/constants/colors.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final LinearGradient gradientColor;
  final double width;
  final double height;
  final bool? boarderColor;

  const DefaultButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.gradientColor = AppColors.primaryColor,
    required this.width,
    required this.height,
    this.boarderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: color,
        gradient: color == null ? gradientColor : null,
        border: boarderColor != null ? Border.all(
          color: Colors.black,
          width: 1,
        ) : null
      ),
      child: TextButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}