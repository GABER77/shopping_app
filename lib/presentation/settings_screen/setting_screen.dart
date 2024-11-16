import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping_app/business_logic/cubit/settings/settings_states.dart';
import 'package:shopping_app/presentation/settings_screen/editable_text_field_widget.dart';
import 'package:shopping_app/shared/widgets/default_button.dart';
import 'package:shopping_app/shared/widgets/progress_indicator.dart';
import '../../business_logic/cubit/settings/settings_cubit.dart';
import '../../data/shared_preferences/cache_helper.dart';
import '../../shared/constants/colors.dart';
import '../../shared/core/navigation.dart';
import '../authentication_screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isEditable = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..getUserData(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if (state is SettingsSuccessState) {
            nameController.text = state.userModel.data!.name!;
            emailController.text = state.userModel.data!.email!;
            phoneController.text = state.userModel.data!.phone!;
          }
        },
        builder: (context, state) {
          return ConditionalProgressIndicator(
            condition: SettingsCubit.get(context).userModel != null,
            widgetIfTrue: Scaffold(
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
                      setState(() {
                        isEditable = !isEditable;
                      });
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
          );
        },
      ),
    );
  }
}