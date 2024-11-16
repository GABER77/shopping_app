class FavoritesRepository {
  FavoritesRepository._privateConstructor();
  static final FavoritesRepository _instance = FavoritesRepository._privateConstructor();
  static FavoritesRepository get instance => _instance;

  Map<int, bool> favorites = {};
}