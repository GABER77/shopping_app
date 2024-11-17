import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import 'package:shopping_app/shared/widgets/progress_indicator.dart';
import '../../business_logic/cubit/profile/profile_cubit.dart';
import '../../business_logic/cubit/profile/profile_states.dart';
import '../../data/shared_preferences/cache_helper.dart';
import '../../shared/constants/colors.dart';
import '../../shared/core/navigation.dart';
import '../authentication_screens/login_screen.dart';
import 'editable_text_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEditable = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserData(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            nameController.text = state.profileModel.data!.name!;
            emailController.text = state.profileModel.data!.email!;
            phoneController.text = state.profileModel.data!.phone!;
          }
        },
        builder: (context, state) {
          return ConditionalProgressIndicator(
            condition: ProfileCubit.get(context).profileModel != null,
            widgetIfTrue: Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(
                  leading: Icon(
                    Icons.notifications,
                    color: AppColors.secondaryColor,
                    size: 22.sp,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (isEditable) {
                          if (formKey.currentState!.validate()) {
                            ProfileCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                            setState(() {
                              isEditable = !isEditable;
                            });
                          }
                        }
                        else {
                          setState(() {
                            isEditable = !isEditable;
                          });
                        }
                      },
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: isEditable
                          ? Text(
                              'Save',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 15.sp,
                              ),
                            )
                          : Icon(
                              Icons.edit,
                              color: AppColors.secondaryColor,
                              size: 22.sp,
                            ),
                    )
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      if(state is ProfileLoadingUpdateState) const LinearProgressIndicator(),
                      SizedBox(
                        height: 17.h,
                      ),
                      EditableTextFormField(
                        labelText: 'Name',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        isEditable: isEditable,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name Required';
                          }
                          return null;
                        },
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      EditableTextFormField(
                        labelText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        isEditable: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email Required';
                          }
                          return null;
                        },
                        prefixIcon: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      EditableTextFormField(
                        labelText: 'Phone',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        isEditable: isEditable,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number Required';
                          }
                          return null;
                        },
                        prefixIcon: Icons.plus_one,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      DefaultButton(
                        onPressed: () {
                          CacheHelper.removeData(key: 'token').then((value) {
                            if (value && context.mounted) {
                              navigateToAndClose(context, LoginScreen());
                            }
                          });
                        },
                        width: 220.w,
                        height: 40.h,
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: AppColors.primaryColor1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}