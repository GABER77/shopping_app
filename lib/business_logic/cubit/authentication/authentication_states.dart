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
class LoginChangePasswordVisibilityState extends AuthenticationStates {}