import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/home/home_cubit/states.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';

class HomeCubit extends Cubit<HomeCubitStates> {
  HomeCubit() : super(HomeCubitInitialState());

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  void changeLightMode() {
    if (CacheHelper.getString("lightMode") != null &&
        CacheHelper.getString("lightMode") == "Light") {
      CacheHelper.setString("lightMode", "Dark");
      lightMode = "Dark";
    } else {
      CacheHelper.setString("lightMode", "Light");
      lightMode = "Light";
    }
    emit(HomeChangeLightModeState());
  }
}
