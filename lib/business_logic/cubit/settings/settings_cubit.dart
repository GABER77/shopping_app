import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import 'package:shopping_app/data/models/login_model.dart';
import '../../../data/api_config/dio_helper.dart';
import '../../../data/shared_preferences/cache_helper.dart';
import 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates>{
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  LoginModel? userModel;

  void getUserData(){
    emit(SettingsLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      userModel = LoginModel.fromJson(value?.data);
      emit(SettingsSuccessState(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(SettingsErrorState());
    });
  }

}