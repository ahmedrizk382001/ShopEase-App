import 'package:shop_app/Models/banners_model.dart';
import 'package:shop_app/Models/products_model.dart';
import 'package:shop_app/Models/search_model.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingState extends ShopState {}

class ShopSuccessState extends ShopState {
  final ShopBannersModel bannersModel;
  final ShopProductsModel productsModel;

  ShopSuccessState({required this.bannersModel, required this.productsModel});
}

class ShopErrorState extends ShopState {
  final String error;

  ShopErrorState({required this.error});
}

class ShopIsSearchOpenState extends ShopState {}

class ShopSearchLoadingState extends ShopState {}

class ShopSearchSuccessState extends ShopState {
  final ShopSearchModel? searchModel;

  ShopSearchSuccessState({required this.searchModel});
}

class ShopSearchErrorState extends ShopState {
  final String error;

  ShopSearchErrorState({required this.error});
}

class ShopFavoritesChangeLoadingState extends ShopState {}

class ShopFavoritesChangeSuccessState extends ShopState {}

class ShopFavoritesChangeErrorState extends ShopState {
  final String error;

  ShopFavoritesChangeErrorState({required this.error});
}
