import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/api_config/dio_helper.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import 'package:shopping_app/data/models/categories_model.dart';
import 'package:shopping_app/data/models/home_model.dart';
import '../../../data/shared_preferences/cache_helper.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  void getHomeData(){
    emit(HomeLoadingState());
    DioHelper.getData(
      url: HOME,
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      homeModel = HomeModel.fromJson(value?.data);
      emit(HomeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  void getCategoriesData(){
    emit(HomeLoadingCategoriesState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value?.data);
      emit(HomeSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorCategoriesState());
    });
  }
}