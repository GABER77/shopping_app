import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/search/search_states.dart';
import 'package:shopping_app/data/api_config/dio_helper.dart';
import 'package:shopping_app/data/api_config/end_points.dart';
import 'package:shopping_app/data/models/search_model.dart';
import '../../../data/shared_preferences/cache_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text' : text,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value){
      searchModel = SearchModel.fromJson(value?.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}