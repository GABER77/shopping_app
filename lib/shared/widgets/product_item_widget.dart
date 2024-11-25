import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../presentation/product_screen/product_screen.dart';
import '../constants/colors.dart';
import '../constants/spaces.dart';
import '../core/navigation.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    this.oldPrice,
    this.extraButton,
    required this.model,
  });

  final String image;
  final String name;
  final dynamic price;
  final dynamic oldPrice;
  final Widget? extraButton;
  final dynamic model;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, ProductScreen(model));
      },
      child: Container(
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.primaryColor2,
        ),
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 105.w,
                height: 85.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                    image: NetworkImage(
                      image,
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          'LE ${price.round()}',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        Spaces.hSpacingM,
                        Text(
                          oldPrice != null
                              ? 'LE ${oldPrice?.round()}'
                              : '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        extraButton ?? const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}