import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/categories_model.dart';
import 'package:shop_app/Models/products_model.dart';
import 'package:shop_app/Modules/categories/categories_cubit/cubit.dart';
import 'package:shop_app/Modules/categories/categories_cubit/states.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';

class CategoriesScreem extends StatelessWidget {
  const CategoriesScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCategoriesCubit()..getCategories(),
      child: BlocConsumer<ShopCategoriesCubit, ShopCategoriesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var categoriesCubit = ShopCategoriesCubit.get(context);
          return ConditionalBuilder(
            condition: state is! ShopCategoriesLoadingState,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildCategoryItem(context,
                            categoriesCubit.categoriesModel.data.data[index]);
                      },
                      separatorBuilder: (context, index) => getDivider(context),
                      itemCount:
                          categoriesCubit.categoriesModel.data.data.length),
                ),
              );
            },
            fallback: (context) => centerIndicator(),
          );
        },
      ),
    );
  }
}

Widget buildCategoryItem(BuildContext context, CategoriesDataModel model) =>
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            //ShopCubit.get(context).getCategoryProducts(model.id);
            //ShopCubit.isCategoryPressed = true;
          },
          child: Container(
            decoration: BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(width: 8, color: defaultColor),
                //bottom: BorderSide(width: 5, color: defaultColor),
              ),
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(model.image),
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      defaultColor,
                      //defaultColor,
                      Colors.white.withOpacity(0)
                    ], begin: Alignment.centerRight, end: Alignment.center),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 80,
                  color: defaultColor,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      model.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black87, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            "See",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black87, fontSize: 20),
                          ),
                          Text(
                            "Products",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black87, fontSize: 20),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );

Widget buildCategoryProductItem(BuildContext context, ProductsDataModel model) {
  return InkWell(
    onTap: () {},
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.network(
              model.image,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return SizedBox(
                    height: 150,
                    width: 150,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: defaultColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                );
              },
            ),
            if (model.discount != 0)
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
        Expanded(
          child: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
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
                          "${model.price.round()} L.E",
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            "${model.oldPrice.round()} L.E",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: defaultColor,
                              decorationThickness: 2,
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
