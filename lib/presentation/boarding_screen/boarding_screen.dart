import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/data/shared_preferences/cache_helper.dart';
import 'package:shopping_app/presentation/authentication_screens/login_screen.dart';
import 'package:shopping_app/shared/constants/colors.dart';
import 'package:shopping_app/shared/core/navigation.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'boarding_item_widget.dart';
import 'boarding_model.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {

  var boardingController = PageController();
  bool isLastPage = false;
  void submitBoarding(context){
    CacheHelper.saveData(key: 'isBoardingComplete', value: true).then((value) {
      if (value && context.mounted) navigateToAndClose(context, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submitBoarding(context);
            },
            child: Text(
              'SKIP',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textColor,
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
                    activeDotColor: AppColors.secondaryColor,
                  ),
                ),
                const Spacer(),
                DefaultButton(
                    onPressed: () {
                      if(isLastPage == true) {
                        submitBoarding(context);
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