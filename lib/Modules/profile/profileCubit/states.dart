import 'package:shop_app/Models/user_model.dart';

abstract class ShopProfileState {}

class ShopProfileInitialState extends ShopProfileState {}

class ShopProfileShowPasswordState extends ShopProfileState {}

class ShopGetUserDataLoadingState extends ShopProfileState {}

class ShopGetUserDataSuccessState extends ShopProfileState {
  ShopUserModel model;

  ShopGetUserDataSuccessState({required this.model});
}

class ShopUserDataErrorState extends ShopProfileState {
  final String error;

  ShopUserDataErrorState({required this.error});
}

class ShopUpdateLoadingState extends ShopProfileState {}

class ShopUpdateSuccessState extends ShopProfileState {
  ShopUserModel model;

  ShopUpdateSuccessState({required this.model});
}

class ShopUpdateErrorState extends ShopProfileState {
  final String error;

  ShopUpdateErrorState({required this.error});
}
