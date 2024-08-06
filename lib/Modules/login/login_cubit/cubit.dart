import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/user_model.dart';
import 'package:shop_app/Modules/login/login_cubit/states.dart';
import 'package:shop_app/Shared/Components/endpoints.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(BuildContext context) =>
      BlocProvider.of<ShopLoginCubit>(context);

  late ShopUserModel loginModel;
  void userLogin(String email, String password) {
    emit(ShopLoginLoadingState());
    DioHelper.post(LOGIN, {'email': email, 'password': password}).then((value) {
      print(value.data);
      loginModel = ShopUserModel.fromJson(value.data);
      emit(ShopLoginSuccessState(model: loginModel));
      CacheHelper.setString("token",
          loginModel.data!.token.isNotEmpty ? loginModel.data!.token : '');
    }).catchError((error) {
      emit(ShopLoginErrorState(error: error.toString()));
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
