import 'package:shop_app/Models/categories_model.dart';
//import 'package:shop_app/Models/products_model.dart';

abstract class ShopCategoriesStates {}

class ShopCategoriesInitialState extends ShopCategoriesStates {}

class ShopCategoriesLoadingState extends ShopCategoriesStates {}

class ShopCategoriesSuccessState extends ShopCategoriesStates {
  final ShopCategoriesModel categoriesModel;

  ShopCategoriesSuccessState({required this.categoriesModel});
}

class ShopCategoriesErrorState extends ShopCategoriesStates {
  final String error;

  ShopCategoriesErrorState({required this.error});
}

/*class ShopCateogriesProductsLoadingState extends ShopCategoriesStates {}

class ShopCateogriesProductsSuccessState extends ShopCategoriesStates {
  final ShopProductsModel categoryProductsModel;

  ShopCateogriesProductsSuccessState({required this.categoryProductsModel});
}

class ShopCateogriesProductsErrorState extends ShopCategoriesStates {
  final String error;

  ShopCateogriesProductsErrorState({required this.error});
}*/
