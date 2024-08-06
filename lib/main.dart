import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_layout.dart';
import 'package:shop_app/Modules/home/home_cubit/cubit.dart';
import 'package:shop_app/Modules/home/home_cubit/states.dart';
import 'package:shop_app/Modules/login/login_screen.dart';
import 'package:shop_app/Modules/onBoarding/on_boarding_screen.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Cubit/bloc_observer.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:shop_app/Shared/Network/Remote/dio_helper.dart';
import 'package:shop_app/Shared/Styles/themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  onBoarding = CacheHelper.getBool('onBoarding') == null ? false : true;
  token = CacheHelper.getString("token") ?? '';
  lightMode = CacheHelper.getString("lightMode") == null
      ? "Light"
      : CacheHelper.getString("lightMode")!;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeCubitStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightModeTheme(context),
          darkTheme: darkModeTheme(context),
          themeMode: lightMode == "Light" ? ThemeMode.light : ThemeMode.dark,
          home: token != ''
              ? const ShopAppLayout()
              : onBoarding == false
                  ? LoginScreen()
                  : OnBoardingScreen(),
        ),
      ),
    );
  }
}
