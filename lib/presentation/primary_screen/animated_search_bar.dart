import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/nav_bar/nav_bar_cubit.dart';
import 'package:shopping_app/shared/constants/colors.dart';

class AnimatedSearchBar extends StatefulWidget {

  final VoidCallback toggleScreen;
  const AnimatedSearchBar({super.key, required this.toggleScreen});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {

  bool isOpen = false;
  bool backButtonPressed = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result){
        if (isOpen) {
          closeSearchBar();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        width: isOpen ? 355.w : 50,
        height: 50,
        decoration: isOpen ? BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.primaryColor2,
        ): null,
        child: isOpen ?
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 15.w,
                    ),
                    child:
                    TextField(
                      controller: searchController,
                      autofocus: true,
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.sp,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.secondaryColor,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: AppColors.secondaryColor,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      closeSearchBar();
                    });
                  },
                ),
              ],
            )
        : IconButton(
          icon: Icon(
            Icons.search,
            color: AppColors.secondaryColor,
            size: 26.sp,
          ),
          onPressed: () {
            setState(() {
              openSearchBar();
            });
          },
        ),
      ),
    );
  }

  void openSearchBar() {
    isOpen = !isOpen;
    widget.toggleScreen();
    context.read<NavBarCubit>().hideNavBar();
    backButtonPressed = true;
  }

  void closeSearchBar() {
    isOpen = !isOpen;
    widget.toggleScreen();
    context.read<NavBarCubit>().showNavBar();
    searchController.clear();
    backButtonPressed = false;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}