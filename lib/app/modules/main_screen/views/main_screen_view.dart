import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';

import '../../search_view/views/search_view_view.dart';
import '../controllers/main_screen_controller.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
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
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: screenHeight * 0.30),
                    child: Material(
                      elevation: 8,
                      type: MaterialType.transparency,
                      child: TextField(
                        //enabled: false,
                        onTap: () {
                          Get.to(const SearchViewView(),
                              transition: Transition.upToDown,
                              fullscreenDialog: true,
                              duration: const Duration(milliseconds: 800));
                          // showSearch(
                          //   useRootNavigator: true,
                          //   context: context,
                          //   delegate: MyCustomSearchDelegate(),
                          // );
                        },
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(TourMaker.search,
                                color: englishViolet, size: 30),
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
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                      elevation: 5,
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
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 30),
                                    child: Text('category', style: paragraph2),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        buildCont(),
                                        buildCont(),
                                        buildCont(),
                                        buildCont(),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        buildCont(),
                                        buildCont(),
                                        buildCont(),
                                        buildCont(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('Trending', style: paragraph1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: screenHeight * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            Material(
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
                                  imageData[index],
                                ),
                              ),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('Exclusive Tours', style: paragraph1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: screenHeight * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            Material(
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
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text('Exclusive Tours', style: paragraph1),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                        height: screenHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView(
                          children: List.generate(
                            8,

                            // scrollDirection: Axis.horizontal,
                            (int index) => Material(
                              borderRadius: BorderRadius.circular(18),
                              // borderOnForeground: false,
                              type: MaterialType.transparency,
                              elevation: 5,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                height: 120,
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
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                        'assets/farshad-rezvanian-Eelegt4hFNc-unsplash.jpg'))),
          ),
          const Text('Mountai')
        ],
      );
}
