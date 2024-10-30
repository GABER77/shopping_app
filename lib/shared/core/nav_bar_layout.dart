import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/nav_bar/nav_bar_cubit.dart';
import 'package:shopping_app/business_logic/cubit/nav_bar/nav_bar_states.dart';
import 'package:shopping_app/shared/constants/colors.dart';

class NavBarLayout extends StatelessWidget {
  const NavBarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit, NavBarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NavBarCubit.get(context);
        return Scaffold(
          bottomNavigationBar: !cubit.isSearchActive? SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 55.h,
                left: 65.w,
                right: 65.w,
              ),
              child: Container(
                height: 47.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: AppColors.navBarColor.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navBarColor.withOpacity(0.5),
                      blurRadius: 30.r,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                      List.generate(
                        cubit.screens.length,
                        (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cubit.changeScreen(index);
                                  },
                                  icon: Icon(
                                    cubit.navBarIcons[index],
                                    size: 25.sp,
                                    color: cubit.currentIndex == index
                                        ? AppColors.navBarSelectedIconColor
                                        : AppColors.navBarNotSelectedIconColor,
                                  ),
                                ),
                                Container(
                                  width: 20.w,
                                  height: 2.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    color: cubit.currentIndex == index
                                        ? AppColors.navBarSelectedIndicatorColor
                                        : AppColors.navBarNotSelectedIndicatorColor,
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ),
                      ),
                  ),
                ),
              ),
            ),
          ) : null,
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}