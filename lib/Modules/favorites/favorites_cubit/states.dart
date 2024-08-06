import 'package:shop_app/Models/favorites_model.dart';

abstract class FavoritesStates {}

class FavoritesInitialState extends FavoritesStates {}

class FavoritesLoadingState extends FavoritesStates {}

class FavoritesSuccessState extends FavoritesStates {
  final ShopFavoritesModel favoritesModel;

  FavoritesSuccessState({required this.favoritesModel});
}

class FavoritesErrorState extends FavoritesStates {
  final String error;

  FavoritesErrorState({required this.error});
}

class FavoritesChangeLoadingState extends FavoritesStates {}

class FavoritesChangeSuccessState extends FavoritesStates {}

class ShopFavoritesChangeErrorState extends FavoritesStates {
  final String error;

  ShopFavoritesChangeErrorState({required this.error});
}
