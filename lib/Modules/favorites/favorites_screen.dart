import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_cubit/cubit.dart';
import 'package:shop_app/Models/favorites_model.dart';
import 'package:shop_app/Modules/favorites/favorites_cubit/cubit.dart';
import 'package:shop_app/Modules/favorites/favorites_cubit/states.dart';
import 'package:shop_app/Modules/home/home_cubit/cubit.dart';
import 'package:shop_app/Modules/home/home_cubit/states.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()..getFavorites(),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! FavoritesLoadingState,
            builder: (context) {
              return FavoritesCubit.get(context)
                      .favoritesModel
                      .data
                      .data
                      .isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildFavoriteItem(
                                context,
                                FavoritesCubit.get(context)
                                    .favoritesModel
                                    .data
                                    .data[index]),
                            separatorBuilder: (context, index) =>
                                getDivider(context),
                            itemCount: FavoritesCubit.get(context)
                                .favoritesModel
                                .data
                                .data
                                .length),
                      ),
                    )
                  : Center(
                      child: Text(
                        "No favorites added yet",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.grey),
                      ),
                    );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildFavoriteItem(BuildContext context, FavoritesDataModel model) =>
    BlocConsumer<HomeCubit, HomeCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Image(
                    image: NetworkImage(model.products.image),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  if (model.products.discount != 0)
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      color: Colors.red,
                      child: const Text(
                        "Discount",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.products.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${model.products.price.round()} L.E",
                                style: TextStyle(
                                  color: defaultColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (model.products.discount != 0)
                                Text(
                                  "${model.products.oldPrice.round()} L.E",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: defaultColor,
                                    decorationThickness: 2,
                                  ),
                                ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavorites(model.products.id);
                                FavoritesCubit.get(context).getFavorites();
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: defaultColor,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
