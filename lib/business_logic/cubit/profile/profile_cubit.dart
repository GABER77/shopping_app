import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import 'package:shopping_app/data/models/login_model.dart';
import '../../../data/api_config/dio_helper.dart';
import '../../../data/shared_preferences/cache_helper.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  LoginModel? profileModel;
  LoginModel? profileUpdateModel;

  void getUserData(){
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      profileModel = LoginModel.fromJson(value?.data);
      emit(ProfileSuccessState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ProfileErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ProfileLoadingUpdateState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      profileUpdateModel = LoginModel.fromJson(value?.data);
      emit(ProfileSuccessUpdateState());
    }).catchError((error){
      print(error.toString());
      emit(ProfileErrorUpdateState());
    });
  }

}