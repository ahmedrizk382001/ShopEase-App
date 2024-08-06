import 'package:shop_app/Models/user_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  ShopUserModel model;

  ShopRegisterSuccessState({required this.model});
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String error;

  ShopRegisterErrorState({required this.error});
}

class ShopLoginShowPasswordState extends ShopRegisterState {}
