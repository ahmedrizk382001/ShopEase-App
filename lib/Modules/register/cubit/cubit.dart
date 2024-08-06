import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/user_model.dart';
import 'package:shop_app/Modules/register/cubit/states.dart';
import 'package:shop_app/Shared/Components/endpoints.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(BuildContext context) =>
      BlocProvider.of<ShopRegisterCubit>(context);

  late ShopUserModel loginModel;
  void userRegister(String name, String phone, String email, String password) {
    emit(ShopRegisterLoadingState());
    DioHelper.post(REGISTER, {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    }).then((value) {
      print(value.data);
      loginModel = ShopUserModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(model: loginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error: error.toString()));
    });
  }

  bool isPassword = true;
  Widget passwordIcon = const Icon(Icons.visibility);

  void changeShowPassowrd() {
    isPassword = !isPassword;
    if (isPassword == false) {
      passwordIcon = const Icon(Icons.visibility_off);
    }
    emit(ShopLoginShowPasswordState());
  }
}
