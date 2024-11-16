abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}
class HomeSuccessState extends HomeStates {}
class HomeErrorState extends HomeStates {}

class HomeLoadingGetCategoriesState extends HomeStates {}
class HomeSuccessGetCategoriesState extends HomeStates {}
class HomeErrorGetCategoriesState extends HomeStates {}

class HomeLoadingChangeFavoriteState extends HomeStates {}
class HomeSuccessChangeFavoriteState extends HomeStates {}
class HomeErrorChangeFavoriteState extends HomeStates {}