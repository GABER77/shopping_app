import 'package:shopping_app/data/models/login_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}
class ProfileSuccessState extends ProfileStates {
  LoginModel profileModel;
  ProfileSuccessState(this.profileModel);
}
class ProfileErrorState extends ProfileStates {}

class ProfileLoadingUpdateState extends ProfileStates {}
class ProfileSuccessUpdateState extends ProfileStates {}
class ProfileErrorUpdateState extends ProfileStates {}