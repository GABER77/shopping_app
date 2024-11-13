import 'package:shopping_app/data/models/login_model.dart';

abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}
class SettingsLoadingState extends SettingsStates {}
class SettingsSuccessState extends SettingsStates {
  LoginModel userModel;
  SettingsSuccessState(this.userModel);
}
class SettingsErrorState extends SettingsStates {}