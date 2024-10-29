import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/presentation/home_screen/animated_search_bar.dart';
import 'package:shopping_app/presentation/search_screen/search_screen.dart';
import '../../shared/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool showScreen1 = true;
  void toggleScreen() {
    setState(() {
      showScreen1 = !showScreen1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
          ),
          child: AppBar(
            title: showScreen1 ? Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.grey[200],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.monoPrimaryColor,
                  size: 25.sp,
                ),
                onPressed: () {},
              ),
            ) : null,
            actions: [
              Padding(
                padding: EdgeInsets.only(
                    right: 15.w
                ),
                child: AnimatedSearchBar(toggleScreen: toggleScreen),
              ),
            ],
          ),
        ),
      ),
      body: showScreen1 ? const Screen1() : const SearchScreen(),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Screen',
      ),
    );
  }
}