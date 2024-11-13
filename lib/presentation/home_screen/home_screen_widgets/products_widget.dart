import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/home/home_cubit.dart';
import 'package:shopping_app/shared/constants/colors.dart';
import '../../../data/models/home_model.dart';
import '../../../shared/constants/spaces.dart';
import '../../favorite_screen/is_favorite_widgets.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Text(
                'Best Selling',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              const Spacer(),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: AppColors.secondaryColor,
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeModel.data!.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 25.w,
                mainAxisExtent: 200.h,
              ),
              itemBuilder: (context, index) =>
                  buildProductGrid(homeModel.data!.products[index], context),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildProductGrid(ProductModel model, context) => Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 155.w,
              height: 130.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    model.image!,
                  ),
                ),
                color: Colors.white,
              ),
            ),
            IconButton(
                onPressed:() {
                  HomeCubit.get(context).changeFavorites(model.id!);
                },
                icon: CircleAvatar(
                  backgroundColor: AppColors.primaryColor2,
                  child: HomeCubit.get(context).favorites[model.id]!
                      ? inFavorites()
                      : notInFavorites(),
                ),
            ),
          ],
        ),
        Container(
          width: 155.w,
          height: 70.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r),
            ),
            color: AppColors.primaryColor2,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'LE ${model.price!.round()}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Spaces.hSpacingM,
                    Text(
                      model.oldPrice != null
                          ? 'LE ${model.oldPrice.round()}'
                          : '',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );