import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/api_config/dio_helper.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import 'package:shopping_app/data/models/categories_model.dart';
import 'package:shopping_app/data/models/home_model.dart';
import '../../../data/models/change_favorites_model.dart';
import '../../../data/shared_preferences/cache_helper.dart';
import '../../../data/repository/favorite_repositery.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  final FavoritesRepository favoritesRepository = FavoritesRepository.instance;

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? changeFavoritesModel;

  void getHomeData(){
    emit(HomeLoadingState());
    DioHelper.getData(
      url: HOME,
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      homeModel = HomeModel.fromJson(value?.data);
      homeModel?.data?.products.forEach((element) {
        favoritesRepository.favorites.addAll({
          element.id! : element.inFavorites ?? false,
        });
      });
      emit(HomeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  void getCategoriesData(){
    emit(HomeLoadingGetCategoriesState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value?.data);
      emit(HomeSuccessGetCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(HomeErrorGetCategoriesState());
    });
  }

  void changeFavorites(int productID){
    favoritesRepository.favorites[productID] = !favoritesRepository.favorites[productID]!;
    emit(HomeLoadingChangeFavoriteState());
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
      emit(HomeSuccessChangeFavoriteState());
    }).catchError((error){
      print(error.toString());
      if(!changeFavoritesModel!.status!){
        favoritesRepository.favorites[productID] = !favoritesRepository.favorites[productID]!;
      }
      emit(HomeErrorChangeFavoriteState());
    });
  }

}