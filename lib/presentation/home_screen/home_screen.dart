import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/models/home_model.dart';
import 'package:shopping_app/presentation/home_screen/home_screen_widgets/categories_widget.dart';
import 'package:shopping_app/shared/constants/colors.dart';
import 'package:shopping_app/shared/constants/spaces.dart';
import '../../business_logic/cubit/home/home_cubit.dart';
import '../../business_logic/cubit/home/home_states.dart';
import '../../data/models/categories_model.dart';
import '../../shared/widgets/progress_indicator.dart';
import 'home_screen_widgets/banners_widget.dart';
import 'home_screen_widgets/products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final homeModel = HomeCubit.get(context).homeModel;
        final categoriesModel = HomeCubit.get(context).categoriesModel;
        return ConditionalProgressIndicator(
          condition: homeModel !=null && categoriesModel != null,
          widgetIfTrue: homeModel != null && categoriesModel != null
            ? homeBuilder(homeModel, categoriesModel)
            : const Center(child: Text('No data available')),
        );
      },
    );
  }
}

Widget homeBuilder(HomeModel homeModel, CategoriesModel categoriesModel) => Container(
  width: double.infinity,
  height: double.infinity,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15.w
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              BannersWidget(homeModel: homeModel),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
        CategoriesWidget(categoriesModel: categoriesModel),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15.w
          ),
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
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
              ProductsWidget(homeModel: homeModel),
            ],
          ),
        ),
      ],
    ),
  ),
);