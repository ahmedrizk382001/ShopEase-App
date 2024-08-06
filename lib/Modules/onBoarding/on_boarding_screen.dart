import 'package:flutter/material.dart';
import 'package:shop_app/Modules/login/login_screen.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Components/constants.dart';
import 'package:shop_app/Shared/Network/Local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingDataModel> onBoardingScreens = [
    OnBoardingDataModel(
        image: 'assets/images/1.jpg',
        title1: "Welcome to...",
        title2: "ShopEase!",
        body:
            "Discover the joy of shopping with personalized recommendations, exclusive deals, and a seamless shopping experience."),
    OnBoardingDataModel(
        image: 'assets/images/2.jpg',
        title1: "Explore",
        title2: "New Collections",
        body:
            "Browse the latest trends and find your perfect style. From fashion to electronics, we have everything you need."),
    OnBoardingDataModel(
        image: 'assets/images/3.jpg',
        title1: "Earn Rewards",
        title2: "as You Shop",
        body:
            "Enjoy loyalty points, special discounts, and early access to sales. The more you shop, the more you save!"),
  ];

  PageController onBoardingController = PageController();

  int currentPage = 0;
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.setbool('onBoarding', true);
                noReturningNavigate(context, LoginScreen());
              },
              child: currentPage == 2
                  ? Text(
                      "NEXT",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: defaultColor,
                          ),
                    )
                  : Text(
                      "SKIP",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: defaultColor,
                          ),
                    ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                controller: onBoardingController,
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(context, onBoardingScreens[index]),
                itemCount: onBoardingScreens.length,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: currentPage == 0
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentPage == 1 || currentPage == 2)
                      FloatingActionButton(
                        onPressed: () {
                          onBoardingController.previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.fastOutSlowIn);
                          setState(() {
                            isLastPage = false;
                          });
                        },
                        backgroundColor: defaultColor,
                        child: const Icon(Icons.arrow_back),
                      ),
                    if (currentPage == 0 || currentPage == 1)
                      FloatingActionButton(
                        onPressed: () {
                          onBoardingController.nextPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.fastOutSlowIn);
                          if (currentPage == 2) {
                            setState(() {
                              isLastPage = true;
                            });
                            CacheHelper.setbool('onBoarding', true);
                          }
                        },
                        backgroundColor: defaultColor,
                        child: const Icon(Icons.arrow_forward),
                      ),
                  ],
                ),
                SmoothPageIndicator(
                  controller: onBoardingController,
                  count: onBoardingScreens.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.black26,
                    spacing: 10,
                    expansionFactor: 2.5,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingDataModel {
  final String image, title1, title2, body;

  OnBoardingDataModel(
      {required this.image,
      required this.title1,
      required this.title2,
      required this.body});
}

Widget buildOnBoardingItem(BuildContext context, OnBoardingDataModel model) =>
    Column(
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title1,
                style: Theme.of(context).textTheme.headlineLarge),
            Text(model.title2,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            Text(model.body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        )
      ],
    );
