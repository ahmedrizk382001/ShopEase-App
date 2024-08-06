import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/categories_model.dart';
import 'package:shop_app/Modules/categories/categories_cubit/states.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Components/endpoints.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';

class ShopCategoriesCubit extends Cubit<ShopCategoriesStates> {
  ShopCategoriesCubit() : super(ShopCategoriesInitialState());

  static ShopCategoriesCubit get(BuildContext context) =>
      BlocProvider.of<ShopCategoriesCubit>(context);

  late ShopCategoriesModel categoriesModel;
  void getCategories() {
    emit(ShopCategoriesLoadingState());
    DioHelper.get(CATEGORIES, token: token).then((value) {
      categoriesModel = ShopCategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState(categoriesModel: categoriesModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState(error: error));
    });
  }
}
