import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/api_config/dio_helper.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import '../../../data/models/login_model.dart';
import 'authentication_states.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates>{
  AuthenticationCubit() : super(LoginInitialState());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordHidden = true;
  LoginModel? loginModel;

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
      loginModel = LoginModel.fromJson(value?.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}