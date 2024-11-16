import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/api_config/dio_helper.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import '../../../data/models/login_model.dart';
import 'authentication_states.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates>{
  AuthenticationCubit() : super(LoginInitialState());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  LoginModel? registerModel;

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

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      },
    ).then((value) {
      registerModel = LoginModel.fromJson(value?.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

}