import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/search/search_cubit.dart';
import 'package:shopping_app/presentation/home_screen/home_screen.dart';
import 'package:shopping_app/presentation/search_screen/search_screen.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';
import 'animated_search_bar.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {

  bool showHomeScreen = true;
  void toggleScreen() {
    setState(() {
      showHomeScreen = !showHomeScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
              ),
              floating: true,
              snap: true,
              leading: showHomeScreen ? IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.secondaryColor,
                  size: 22.sp,
                ),
                onPressed: () {},
              ) : null,
              title: showHomeScreen ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Cart.png',
                    width: 32.w,
                    height: 32.h,
                    color: AppColors.secondaryColor,
                  ),
                  Spaces.hSpacingS,
                  Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ) : null,
              actions: [
                AnimatedSearchBar(toggleScreen: toggleScreen),
              ],
            ),
          ],
          body: showHomeScreen ? const HomeScreen() : SearchScreen(),
        ),
      ),
    );
  }
}