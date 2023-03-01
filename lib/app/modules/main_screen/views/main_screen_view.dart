import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/main_screen_controller.dart';

//? hiii
//! dmvl
//* dfd

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (MainScreenView? state) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildHeadSection(screenHeight, context),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCategories(screenHeight),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('Trending', style: paragraph1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildTrending(screenHeight),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('Exclusive Tours', style: paragraph1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildExclusive(screenHeight, screenWidth),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('Travel Types', style: paragraph1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildTravelTypes(screenHeight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTravelTypes(double screenHeight) {
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView.builder(
        itemCount: 15,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => Material(
          borderRadius: BorderRadius.circular(18),
          // borderOnForeground: false,
          type: MaterialType.transparency,
          elevation: 5,
          child: Container(
            margin: const EdgeInsets.all(10),
            // padding: const EdgeInsets.all(10),
            height: 88,
            // width: screenWidth * 0.75,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/farshad-rezvanian-Eelegt4hFNc-unsplash.jpg',
                ),
              ),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Container buildExclusive(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => Material(
          borderRadius: BorderRadius.circular(18),
          // borderOnForeground: false,
          type: MaterialType.transparency,
          elevation: 5,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            // height: 100,
            width: screenWidth * 0.75,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageData[index],
                ),
              ),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTrending(double screenHeight) {
    return Obx(
      () => controller.trendingToursList.isEmpty
          ? const CustomLoadingScreen()
          : Container(
              height: screenHeight * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: RefreshIndicator(
                onRefresh: () => controller.getTrending(),
                child: ListView.builder(
                  itemCount: controller.trendingToursList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => Hero(
                    tag: controller.trendingToursList[index],
                    child: Material(
                      borderRadius: BorderRadius.circular(18),
                      // borderOnForeground: false,

                      type: MaterialType.transparency,
                      elevation: 5,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        // height: 100,
                        width: 171,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              controller.trendingToursList[index].image
                                  .toString(),
                            ),
                          ),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 40),
                              Column(
                                children: <Widget>[
                                  Text(
                                    controller
                                        .trendingToursList[index].destination
                                        .toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Tahu',
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    'Tours',
                                    style: TextStyle(
                                      fontFamily: 'Tahu',
                                      fontSize: 20,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    'Starting From: ',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    controller
                                        .trendingToursList[index].minAmount
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Material buildCategories(double screenHeight) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(30),
      child: Container(
          height: screenHeight * 0.35,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 18),
                    child: Text('     category', style: paragraph2),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: SizedBox(
                    height: 190,
                    child: Obx(
                      () => controller.categoryList.isEmpty
                          ? const CustomLoadingScreen()
                          : GridView.builder(
                              itemCount: controller.categoryList.length,
                              physics: controller.categoryList.length <= 8
                                  ? const NeverScrollableScrollPhysics()
                                  : const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 5,
                                crossAxisCount: 4,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () =>
                                      controller.onClickedSingleCategory(
                                          controller.categoryList[index].name
                                              .toString(),
                                          controller.categoryList[index].image
                                              .toString()),
                                  child: SizedBox(
                                    height: 73,
                                    width: 73,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 53,
                                          height: 53,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  controller
                                                      .categoryList[index].image
                                                      .toString(),
                                                ),
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.blue),
                                        ),
                                        Text(
                                            controller.categoryList[index].name
                                                .toString(),
                                            style: paragraph4),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  )),
            ],
          )),
    );
  }

  Stack buildHeadSection(double screenHeight, BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenHeight * 0.4,
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage(
                  'assets/farshad-rezvanian-Eelegt4hFNc-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 80.w),
          child: badges.Badge(
            badgeContent: Text(
              '3',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            badgeAnimation: const badges.BadgeAnimation.fade(),
            ignorePointer: true,
            badgeStyle: badges.BadgeStyle(
              borderRadius: BorderRadius.circular(50),
            ),
            position: badges.BadgePosition.topEnd(end: -28, top: -12),
            child: Icon(TourMaker.notification, color: englishViolet),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100),
          child: Image.asset('assets/Logo.png', height: 50),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: 20, right: 20, top: screenHeight * 0.30),
          child: Material(
            elevation: 8,
            type: MaterialType.transparency,
            child: TextField(
              //enabled: false,
              focusNode: controller.searchFocusNode,
              controller: controller.textController,
              onTap: () => controller.onSearchClicked(),

              // Future.delayed(const Duration(milliseconds: 100), () {
              //   showSearch(
              //     useRootNavigator: true,
              //     context: context,
              // delegate: MyCustomSearchDelegate(),
              //   );
              // });
              // },
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(TourMaker.search, color: englishViolet, size: 30),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search Destinations',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(18),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildExc() => Container(
        width: 100.w,
        height: 170,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(18),
        ),
      );
  Widget buildCont() => Column(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/farshad-rezvanian-Eelegt4hFNc-unsplash.jpg'),
              ),
            ),
          ),
          const Text('Mountai')
        ],
      );
}
