import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/presentation/authentication_screens/rounded_clip_path.dart';
import 'package:shopping_app/presentation/authentication_screens/text_field_widget.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: RoundedClipPath(),
                  child: Container(
                    width: double.infinity,
                    height: 250.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFEC407A),
                          Color(0xFFFFB74D),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15.h,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Spaces.vSpacingS,
                            Image.asset(
                              'assets/images/Cart.png',
                              width: 80.w,
                              height: 80.h,
                            ),
                            Spaces.vSpacingS,
                            Text(
                              'Shop Smart, Save Big',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Like Never Before',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical: 25.h
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'Email',
                      controller: emailController,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    ),
                    Spaces.vSpacingM,
                    CustomTextFormField(
                      labelText: 'Password',
                      controller: passwordController,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: Icons.visibility_outlined,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                    ),
                    Spaces.vSpacingXL,
                    DefaultButton(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.sp,
                        ),
                      ),
                      onPressed: () {},
                      width: 220.w,
                      height: 40.h,
                    ),
                    Spaces.vSpacingL,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultButton(
                          child: Image.asset(
                            'assets/images/Facebook.png',
                            color: Colors.white,
                          ),
                          onPressed: () {},
                          width: 120.w,
                          height: 35.h,
                          color: Color(0xff1877F2),
                        ),
                        Spacer(),
                        DefaultButton(
                          child: Image.asset('assets/images/Google.png'),
                          onPressed: () {},
                          width: 120.w,
                          height: 35.h,
                          color: Colors.white70,
                          boarderColor: true,
                        ),
                      ],
                    ),
                    Spaces.vSpacingL,
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: AppColors.monoPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}