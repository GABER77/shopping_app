import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/favorite/favorite_states.dart';
import 'package:shopping_app/data/api_config/dio_helper.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import '../../../data/models/change_favorites_model.dart';
import '../../../data/models/favorites_model.dart';
import '../../../data/shared_preferences/cache_helper.dart';
import '../../../data/repository/favorite_repositery.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitialState());

  static FavoriteCubit get(context) => BlocProvider.of(context);
  final FavoritesRepository favoritesRepository = FavoritesRepository.instance;

  FavoritesModel? favoritesModel;
  ChangeFavoritesModel? changeFavoritesModel;

  void getFavoritesData(){
    emit(FavoriteLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value?.data);
      emit(FavoriteSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(FavoriteErrorState());
    });
  }

  void changeFavorites(int productID){
    favoritesRepository.favorites[productID] = !favoritesRepository.favorites[productID]!;
    emit(FavoriteLoadingChangeState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id' : productID,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      if(!changeFavoritesModel!.status!){
        favoritesRepository.favorites[productID] = !favoritesRepository.favorites[productID]!;
      }
      emit(FavoriteSuccessChangeState());
    }).catchError((error){
      print(error.toString());
      if(!changeFavoritesModel!.status!){
        favoritesRepository.favorites[productID] = !favoritesRepository.favorites[productID]!;
      }
      emit(FavoriteErrorChangeState());
    });
  }

}