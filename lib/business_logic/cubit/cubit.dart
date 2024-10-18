import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/states.dart';
import 'package:shopping_app/data/dio_helper.dart';
import 'package:shopping_app/data/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordHidden = true;

  void changePasswordVisibility(){
    isPasswordHidden = !isPasswordHidden;
    suffixIcon = isPasswordHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email' : email,
        'password' : password,
      },
    ).then((value) {
      print(value?.data);
      emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}