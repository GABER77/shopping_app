import 'package:shopping_app/data/models/change_favorites_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}
class HomeSuccessState extends HomeStates {}
class HomeErrorState extends HomeStates {}

class HomeLoadingCategoriesState extends HomeStates {}
class HomeSuccessCategoriesState extends HomeStates {}
class HomeErrorCategoriesState extends HomeStates {}

class HomeLoadingChangeFavoritesState extends HomeStates {}
class HomeSuccessChangeFavoritesState extends HomeStates {
  final ChangeFavoritesModel model;
  HomeSuccessChangeFavoritesState(this.model);
}
class HomeErrorChangeFavoritesState extends HomeStates {}