import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/categories_model.dart';
import '../../../shared/constants/colors.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.categoriesModel,
  });

  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w
          ),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        SizedBox(
          height: 95.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
            separatorBuilder: (context, index) => SizedBox(
              width: 12.w,
            ),
            itemCount: categoriesModel.data!.data.length,
          ),
        ),
      ],
    );
  }
}

Widget buildCategoryItem(CategoryModel model) => Column(
  children: [
    Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            model.image!
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
    SizedBox(
      height: 5.h,
    ),
    SizedBox(
      width: 70.w,
      child: Text(
        model.name!,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.sp,
          color: AppColors.textColor,
          height: 1.3,
        ),
      ),
    ),
  ],
);