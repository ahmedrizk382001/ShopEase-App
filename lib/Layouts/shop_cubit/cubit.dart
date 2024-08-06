import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_cubit/states.dart';
import 'package:shop_app/Models/banners_model.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Models/products_model.dart';
import 'package:shop_app/Models/search_model.dart';
import 'package:shop_app/Modules/categories/categories_screen.dart';
import 'package:shop_app/Modules/favorites/favorites_screen.dart';
import 'package:shop_app/Modules/home/home_screen.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Components/endpoints.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(BuildContext context) =>
      BlocProvider.of<ShopCubit>(context);

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: "Categories"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: "Favorites"),
  ];

  int bottomNavCurrentIndex = 0;

  void changeBottomNav(int index) {
    bottomNavCurrentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  List<Widget> homeScreen = [
    HomeScreen(),
    CategoriesScreem(),
    FavoritesScreen()
  ];

  late ShopBannersModel bannersModel;
  static late ShopProductsModel productsModel;
  static Map<int, dynamic> favorites = {};
  ShopSearchModel? searchModel;

  void getShopData() {
    emit(ShopLoadingState());
    Future.wait([
      _getBanners(),
      _getProducts(),
    ]).then((responses) {
      emit(ShopSuccessState(
        bannersModel: bannersModel,
        productsModel: productsModel,
      ));
    }).catchError((error) {
      emit(ShopErrorState(error: error.toString()));
    });
  }

  Future<void> _getBanners() async {
    try {
      final response = await DioHelper.get(BANNERS, token: token);
      bannersModel = ShopBannersModel.fromJson(response.data);
    } catch (error) {
      emit(ShopErrorState(error: error.toString()));
      rethrow;
    }
  }

  Future<void> _getProducts() async {
    try {
      final response = await DioHelper.get(PRODUCTS, token: token);
      productsModel = ShopProductsModel.fromJson(response.data);
      for (var element in productsModel.data.data) {
        favorites.addAll({element.id: element.inFavorites});
      }
    } catch (error) {
      print(error.toString());
      emit(ShopErrorState(error: error.toString()));
      rethrow;
    }
  }

  bool isSearchOpen = false;

  void changeIsSearchOpen() {
    isSearchOpen = !isSearchOpen;
    emit(ShopIsSearchOpenState());
  }

  void getSearch(String text) async {
    if (text != '') {
      emit(ShopSearchLoadingState());
      try {
        final response = await DioHelper.post(
          SEARCH,
          {'text': text},
          token: token,
        );
        searchModel = ShopSearchModel.fromJson(response.data);
        emit(ShopSearchSuccessState(
          searchModel: searchModel,
        ));
        print(searchModel?.status);
      } catch (error) {
        print(error.toString());
        emit(ShopSearchErrorState(error: error.toString()));
        rethrow;
      }
    }
  }

  static late ShopChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) async {
    emit(ShopFavoritesChangeLoadingState());
    for (var element in productsModel.data.data) {
      if (element.id == productId) {
        element.inFavorites = !element.inFavorites;
        favorites[element.id] = !ShopCubit.favorites[element.id];
      }
    }
    emit(ShopFavoritesChangeSuccessState());
    DioHelper.post(
      FAVORITES,
      {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ShopChangeFavoritesModel.fromJson(value.data);
      emit(ShopFavoritesChangeSuccessState());
      print(changeFavoritesModel.message);
    }).catchError((error) {
      print(error.toString());
      for (var element in productsModel.data.data) {
        if (element.id == productId) {
          element.inFavorites = !element.inFavorites;
          favorites[element.id] = !ShopCubit.favorites[element.id];
        }
      }
      emit(ShopFavoritesChangeErrorState(error: error));
    });
  }
}
