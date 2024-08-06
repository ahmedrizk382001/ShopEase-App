import 'package:shop_app/Models/user_model.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginShowPasswordState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  ShopUserModel model;

  ShopLoginSuccessState({required this.model});
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;

  ShopLoginErrorState({required this.error});
}
