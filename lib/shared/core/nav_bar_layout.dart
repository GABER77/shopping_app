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
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 40.h,
                left: 65.w,
                right: 65.w,
              ),
              child: Container(
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: AppColors.navBarColor.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navBarColor.withOpacity(0.5),
                      offset: const Offset(0,20),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                    List.generate(
                      cubit.screens.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cubit.currentIndex == index
                              ? AppColors.navBarSelectedCircleColor
                              : AppColors.navBarNotSelectedCircleColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            cubit.changeScreen(index);
                          },
                          icon: Icon(
                            cubit.navBarIcons[index],
                            size: 30.sp,
                            color: cubit.currentIndex == index
                                ? AppColors.navBarSelectedIconColor
                                : AppColors.navBarNotSelectedIconColor,
                          ),
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
