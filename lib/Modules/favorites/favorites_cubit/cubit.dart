import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_cubit/cubit.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Modules/favorites/favorites_cubit/states.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Components/endpoints.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  static FavoritesCubit get(BuildContext context) =>
      BlocProvider.of<FavoritesCubit>(context);

  late ShopFavoritesModel favoritesModel;

  void getFavorites() async {
    emit(FavoritesLoadingState());
    await Future.delayed(Duration(milliseconds: 500));
    DioHelper.get(FAVORITES, token: token).then((value) {
      favoritesModel = ShopFavoritesModel.fromJson(value.data);
      emit(FavoritesSuccessState(favoritesModel: favoritesModel));
    }).catchError((error) {
      print(error.toString());
      emit(FavoritesErrorState(error: error.toString()));
    });
  }

  void changeFavorites(int productId) async {
    emit(FavoritesChangeLoadingState());
    for (var element in ShopCubit.productsModel.data.data) {
      if (element.id == productId) {
        element.inFavorites = !element.inFavorites;
        ShopCubit.favorites[element.id] = !ShopCubit.favorites[element.id];
      }
    }
    emit(FavoritesChangeSuccessState());
    DioHelper.post(
      FAVORITES,
      {'product_id': productId},
      token: token,
    ).then((value) {
      ShopCubit.changeFavoritesModel =
          ShopChangeFavoritesModel.fromJson(value.data);
      getFavorites();
      emit(FavoritesChangeSuccessState());
    }).catchError((error) {
      print(error.toString());
      for (var element in ShopCubit.productsModel.data.data) {
        if (element.id == productId) {
          element.inFavorites = !element.inFavorites;
          ShopCubit.favorites[element.id] = !ShopCubit.favorites[element.id];
        }
      }
      emit(ShopFavoritesChangeErrorState(error: error));
    });
  }
}
