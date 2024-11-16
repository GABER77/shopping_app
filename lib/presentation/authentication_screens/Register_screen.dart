import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/authentication/authentication_cubit.dart';
import 'package:shopping_app/presentation/authentication_screens/login_screen.dart';
import 'package:shopping_app/presentation/authentication_screens/rounded_clip_path.dart';
import 'package:shopping_app/presentation/authentication_screens/text_field_widget.dart';
import 'package:shopping_app/shared/core/navigation.dart';
import 'package:shopping_app/shared/core/toast.dart';
import 'package:shopping_app/shared/widgets/progress_indicator.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import '../../business_logic/cubit/authentication/authentication_states.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/spaces.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  bool isAgreed = false;

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
          if(state is RegisterSuccessState){
            if(state.registerModel.status ?? false){
              customToast(
                message: state.registerModel.message,
                state: ToastStates.SUCCESS,
              );
            }
            else{
              customToast(
                message: state.registerModel.message,
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
                    alignment: Alignment.center,
                    children: [
                      ClipPath(
                        clipper: RoundedClipPath(),
                        child: Container(
                          width: double.infinity,
                          height: 115.h,
                          color: AppColors.primaryColor2,
                        ),
                      ),
                      Text(
                        'Create New Account',
                        style: TextStyle(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor,
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
                            labelText: 'User Name',
                            controller: nameController,
                            prefixIcon: Icons.person,
                            keyboardType: TextInputType.name,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your Name';
                              }
                              return null;
                            },
                          ),
                          Spaces.vSpacingM,
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
                          Spaces.vSpacingM,
                          CustomTextFormField(
                            labelText: 'Re-enter Password',
                            controller: confirmPasswordController,
                            prefixIcon: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please re-enter your Password';
                              }
                              if(value != passwordController.text){
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          Spaces.vSpacingM,
                          CustomTextFormField(
                            labelText: 'Phone Number',
                            controller: phoneController,
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your Phone Number';
                              }
                              return null;
                            },
                          ),
                          Spaces.vSpacingM,
                          CheckboxListTile(
                            title: Text(
                              'I agree to the Terms and Conditions',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            value: isAgreed,
                            onChanged: (bool? value) {
                              setState(() {
                                isAgreed = value ?? false;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: AppColors.secondaryColor,
                          ),
                          Spaces.vSpacingM,
                          ConditionalProgressIndicator(
                            condition: state is! RegisterLoadingState,
                            widgetIfTrue: DefaultButton(
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  if (isAgreed) {
                                    AuthenticationCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                  else {
                                    customToast(
                                        state: ToastStates.ERROR,
                                        message: 'Please accept the terms'
                                    );
                                  }
                                }
                              },
                              width: 220.w,
                              height: 40.h,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primaryColor1,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ),
                          Spaces.vSpacingM,
                          Text(
                            "Already have an account",
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateToAndClose(context, LoginScreen());
                            },
                            child: Text(
                              "Log In",
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