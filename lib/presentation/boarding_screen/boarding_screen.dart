import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/presentation/authentication_screens/login_screen.dart';
import 'package:shopping_app/shared/constants/colors.dart';
import 'package:shopping_app/shared/core/navigation.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'boarding_item_widget.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});


  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {

  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/OnBoarding1.jpg',
        title: 'Discover',
        body: 'Explore top brands, unbeatable deals, and personalized recommendations. Your perfect shopping experience starts here!' ,
    ),
    BoardingModel(
        image: 'assets/images/OnBoarding2.jpg',
        title: 'Secure & Fast Checkout',
        body: 'Save your payment details for a fast, hassle-free, and secure shopping experience every time.' ,
    ),
    BoardingModel(
        image: 'assets/images/OnBoarding3.jpg',
        title: 'Enjoy',
        body: 'Experience fast and reliable delivery, with options to choose express shipping for urgent purchases.' ,
    ),
  ];
  var boardingController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              navigateToAndClose(context, LoginScreen());
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.monoPrimaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardingController,
              onPageChanged: (index) {
                if (index == boardingList.length - 1)
                {
                  setState(() {
                    isLastPage = true;
                  });
                }
                else
                {
                  setState(() {
                    isLastPage = false;
                  });
                }
              },
              itemBuilder: (context, index) => BoardingItem(model: boardingList[index]),
              itemCount: boardingList.length,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 20.w,
              left: 20.w,
              top: 10.h,
              bottom: 30.h,
            ),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingList.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.monoPrimaryColor,
                  ),
                ),
                const Spacer(),
                DefaultButton(
                    onPressed: () {
                      if(isLastPage == true) {
                        navigateToAndClose(context, LoginScreen());
                      }
                      else {
                        boardingController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    width: 57,
                    height: 57,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}