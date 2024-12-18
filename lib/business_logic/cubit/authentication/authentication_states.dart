import 'package:shopping_app/data/models/login_model.dart';

abstract class AuthenticationStates {}

class LoginInitialState extends AuthenticationStates {}

class LoginLoadingState extends AuthenticationStates {}
class LoginSuccessState extends AuthenticationStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends AuthenticationStates {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends AuthenticationStates {}
class RegisterSuccessState extends AuthenticationStates {
  final LoginModel registerModel;
  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends AuthenticationStates {
  final String error;
  RegisterErrorState(this.error);
}