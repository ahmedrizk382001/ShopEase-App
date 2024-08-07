import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layouts/shop_cubit/cubit.dart';
import 'package:shop_app/Layouts/shop_cubit/states.dart';
import 'package:shop_app/Models/banners_model.dart';
import 'package:shop_app/Models/products_model.dart';
import 'package:shop_app/Models/search_model.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeCubit = ShopCubit.get(context);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                builtTextFormField(context, onTap: () {
                  homeCubit.changeIsSearchOpen();
                }, onFieldSubmitted: (value) {
                  homeCubit.changeIsSearchOpen();
                  searchController.text = '';
                }, onChanged: (value) {
                  homeCubit.getSearch(value.toString());
                }, validatorFunc: (value) {
                  if (value!.isEmpty) {
                    return 'please enter something';
                  } else {
                    return null;
                  }
                },
                    labelText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    controller: searchController),
                if (homeCubit.isSearchOpen)
                  SizedBox(
                    height: 20,
                  ),
                if (homeCubit.isSearchOpen)
                  ConditionalBuilder(
                    condition: state is ShopSearchSuccessState,
                    builder: (context) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildSearchItem(
                              context, homeCubit.searchModel!.data.data[index]);
                        },
                        itemCount: homeCubit.searchModel!.data.data.length,
                      );
                    },
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(
                        color: defaultColor,
                      ),
                    ),
                  ),
                if (!homeCubit.isSearchOpen)
                  const SizedBox(
                    height: 30,
                  ),
                if (!homeCubit.isSearchOpen)
                  ConditionalBuilder(
                    condition: state is! ShopLoadingState,
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount Coupons",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BannerCarousel(),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Hot Products",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.6,
                            children: List.generate(
                                ShopCubit.productsModel.data.data.length,
                                (index) => buildProductItem(context,
                                    ShopCubit.productsModel.data.data[index])),
                          )
                        ],
                      );
                    },
                    fallback: (context) => centerIndicator(),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildBannerItem(BuildContext context, BannersDataModel model) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Image.network(
        model.image,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return SizedBox(
              height: 200,
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
          return Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          );
        },
      ),
    ],
  );
}

Widget buildProductItem(BuildContext context, ProductsDataModel model) {
  return InkWell(
    onTap: () {},
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: BorderDirectional(
              bottom: BorderSide(width: 1, color: defaultColor),
            ),
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Image.network(
                model.image,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return SizedBox(
                      height: 180,
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
                  return Center(
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
        ),
        Text(
          model.name,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${model.price.round()} L.E",
              style: TextStyle(
                color: defaultColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
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
                  fontSize: 11,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: defaultColor,
                  decorationThickness: 2,
                ),
              ),
            Spacer(),
            IconButton(
              onPressed: () {
                ShopCubit.get(context).changeFavorites(model.id);
              },
              icon: model.inFavorites == true
                  ? Icon(
                      Icons.favorite,
                      color: defaultColor,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: defaultColor,
                    ),
            )
          ],
        )
      ],
    ),
  );
}

Widget buildSearchItem(BuildContext context, SearchDataModel model) => InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: BorderDirectional(
                  bottom: BorderSide(width: 1, color: defaultColor)),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 180,
                ),
              ],
            ),
          ),
          Text(
            model.name,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${model.price.round()} L.E",
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
    );

class BannerCarousel extends StatefulWidget {
  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.0, // Set the desired height here
          child: PageView.builder(
            controller: _pageController,
            itemCount: ShopCubit.get(context).bannersModel.data.length,
            itemBuilder: (context, index) {
              return buildBannerItem(
                  context, ShopCubit.get(context).bannersModel.data[index]);
            },
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              // Optionally handle page changes here
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SmoothPageIndicator(
            controller: _pageController,
            count: ShopCubit.get(context).bannersModel.data.length,
            effect: WormEffect(
              activeDotColor: defaultColor,
            ), // Customize this as needed
          ),
        ),
      ],
    );
  }
}
