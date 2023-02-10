import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tour_maker/core/theme/style.dart';
import 'package:tour_maker/core/tour_maker_icons.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_search_delegate.dart';
import '../../search_view/views/search_view_view.dart';
import '../controllers/main_screen_controller.dart';

class MainScreenView extends GetView<MainScreenController> {
  const MainScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MainScreenController());
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
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
                          Get.to(SearchViewView(),
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
                          hintText: "Search Destinations",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
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
                  children: [
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
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 30),
                                    child: Text("category", style: paragraph2),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildCont(),
                                        buildCont(),
                                        buildCont(),
                                        buildCont(),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Trending", style: paragraph1),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: screenHeight * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Material(
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Exclusive Tours", style: paragraph1),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: screenHeight * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Material(
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
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Exclusive Tours", style: paragraph1),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: screenHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView(
                          children: List.generate(
                            8,

                            // scrollDirection: Axis.horizontal,
                            (index) => Material(
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

  buildCont() => Column(
        children: [
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
          Text("Mountai")
        ],
      );
}
