import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/user_model.dart';
import 'package:shop_app/Modules/profile/profileCubit/states.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Components/endpoints.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';

class ShopProfileCubit extends Cubit<ShopProfileState> {
  ShopProfileCubit() : super(ShopProfileInitialState());

  static ShopProfileCubit get(BuildContext context) =>
      BlocProvider.of<ShopProfileCubit>(context);

  late ShopUserModel getUserDataModel;
  late ShopUserModel loginModel;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.get(PROFILE, token: token).then((value) {
      getUserDataModel = ShopUserModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessState(model: getUserDataModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserDataErrorState(error: error));
    });
  }

  void userUpdate(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(ShopUpdateLoadingState());
    DioHelper.put(UPDATE, {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopUserModel.fromJson(value.data);
      getUserData();
      emit(ShopUpdateSuccessState(model: loginModel));
    }).catchError((error) {
      emit(ShopUpdateErrorState(error: error.toString()));
    });
  }

  bool isPassword = true;
  Widget passwordIcon = const Icon(Icons.visibility);

  void changeShowPassowrd() {
    isPassword = !isPassword;
    if (isPassword == false) {
      passwordIcon = const Icon(Icons.visibility_off);
    }
    emit(ShopProfileShowPasswordState());
  }
}
