import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:shopping_app/business_logic/cubit/nav_bar/nav_bar_cubit.dart';
import 'package:shopping_app/data/shared_preferences/cache_helper.dart';
import 'package:shopping_app/presentation/authentication_screens/Register_screen.dart';
import 'package:shopping_app/presentation/authentication_screens/rounded_clip_path.dart';
import 'package:shopping_app/presentation/authentication_screens/text_field_widget.dart';
import 'package:shopping_app/shared/core/nav_bar_layout.dart';
import 'package:shopping_app/shared/core/navigation.dart';
import 'package:shopping_app/shared/core/toast.dart';
import 'package:shopping_app/shared/widgets/progress_indicator.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import '../../business_logic/cubit/authentication/authentication_states.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor2,
      ));

    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
            if(state.loginModel.status ?? false){
              final token = state.loginModel.data?.token;
              CacheHelper.saveData(key: 'token', value: token).then((value) {
                if (context.mounted){
                  context.read<NavBarCubit>().currentIndex = 0;
                  navigateToAndClose(context, const NavBarLayout());
                }
              });
            }
            else{
              customToast(
                message: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
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
                          color: AppColors.primaryColor2,
                        ),
                      ),
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 18.h,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  Spaces.vSpacingS,
                                  Image.asset(
                                    'assets/images/Cart.png',
                                    width: 80.w,
                                    height: 80.h,
                                    color: AppColors.secondaryColor,
                                  ),
                                  Spaces.vSpacingS,
                                  Text(
                                    'Shop Smart, Save Big',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                  Text(
                                    'Like Never Before',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.secondaryColor,
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
                            labelText: 'Email Address',
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
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),
                          Spaces.vSpacingXL,
                          ConditionalProgressIndicator(
                            condition: state is! LoginLoadingState,
                            widgetIfTrue: DefaultButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  AuthenticationCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              width: 220.w,
                              height: 40.h,
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  color: AppColors.primaryColor1,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ),
                          Spaces.vSpacingL,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultButton(
                                onPressed: () {},
                                width: 120.w,
                                height: 35.h,
                                color: const Color(0xff1877F2),
                                child: Image.asset(
                                  'assets/images/Facebook.png',
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              DefaultButton(
                                onPressed: () {},
                                width: 120.w,
                                height: 35.h,
                                color: Colors.white,
                                boarderColor: true,
                                child: Image.asset(
                                    'assets/images/Google.png'
                                ),
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
                            onPressed: () {
                              navigateToAndClose(context, const RegisterScreen());
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: AppColors.textColor,
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
        },
      )
    );
  }
}