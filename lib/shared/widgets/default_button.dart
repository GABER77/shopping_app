import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/shared/constants/colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final bool? boarderColor;
  final Widget child;

  const DefaultButton({
    super.key,
    required this.onPressed,
    this.color = AppColors.secondaryColor,
    required this.width,
    required this.height,
    this.boarderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: color,
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