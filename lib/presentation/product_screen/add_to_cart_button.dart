import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/shared/constants/colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.productID});
  final int productID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 65.w,
        left: 65.w,
        bottom: 30.h,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 45.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: AppColors.secondaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 20.r,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}