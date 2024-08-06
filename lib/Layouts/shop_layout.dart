import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_cubit/cubit.dart';
import 'package:shop_app/Layouts/shop_cubit/states.dart';
import 'package:shop_app/Modules/home/home_cubit/cubit.dart';
import 'package:shop_app/Modules/profile/profile_screen.dart';
import 'package:shop_app/Shared/Components/constants.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getShopData(),
      child: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {},
          builder: (context, state) {
            var homeCubit = ShopCubit.get(context);
            print(token);
            return Scaffold(
              appBar: AppBar(
                title: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Shop",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                  ),
                  TextSpan(
                    text: "Ease!",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: defaultColor,
                        ),
                  ),
                ])),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ));
                      },
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        size: 25,
                      )),
                  IconButton(
                      onPressed: () {
                        HomeCubit.get(context).changeLightMode();
                      },
                      icon: Icon(
                        Icons.brightness_4_outlined,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        size: 25,
                      ))
                ],
              ),
              bottomNavigationBar: state is! ShopLoadingState
                  ? BottomNavigationBar(
                      onTap: (index) {
                        homeCubit.changeBottomNav(index);
                      },
                      backgroundColor: defaultColor,
                      items: homeCubit.bottomItems,
                      currentIndex: homeCubit.bottomNavCurrentIndex,
                    )
                  : null,
              body: homeCubit.homeScreen[homeCubit.bottomNavCurrentIndex],
            );
          }),
    );
  }
}
