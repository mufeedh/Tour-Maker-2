import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/single_tour_controller.dart';

class SingleTourView extends GetView<SingleTourController> {
  const SingleTourView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final SingleTourController controller = Get.put(SingleTourController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[
            Obx(() {
              return GestureDetector(
                onTap: () => controller.onClickAddToFavourites(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: controller.isFavourite.value
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(Icons.favorite_outline),
                  ),
                ),
              );
            }),
            const SizedBox(
              width: 20,
              height: 20,
            )
          ],
        ),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (SingleTourView? state) => Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: '${controller.singleTour[0].tourData?.image}',
                imageBuilder: (BuildContext context,
                        ImageProvider<Object> imageProvider) =>
                    Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: 40.h,
                  width: 100.w,
                ),
              ),
              Positioned(
                // top: 80,
                left: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Text(
                    '${controller.singleTour[0].tourData?.name!.split(' ').join('\n')}',
                    style: const TextStyle(
                      fontFamily: 'Tahu',
                      color: Colors.white,
                      fontSize: 56,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: screenWidth - 116,
                    ),
                    Container(
                      // height: 50.h,
                      width: 100.w,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 70),
                                child: Text(
                                  '${controller.singleTour[0].tourData?.tourCode}',
                                  style: heading2,
                                ),
                              ),
                              Tooltip(
                                message: 'VIEW ITINERARY',
                                preferBelow: false,
                                decoration: BoxDecoration(
                                  color: englishViolet,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  // tooltip: 'VIEW ITINERARY',
                                  icon: Icon(
                                    TourMaker.group_2,
                                    color: englishViolet,
                                    size: 21,
                                  ),
                                  onPressed: () => controller
                                      .onViewItineraryClicked(controller
                                          .singleTour[0].tourData!.itinerary!),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              Text('   Tour Description', style: subheading1),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                '${controller.singleTour[0].tourData?.description}',
                                style: paragraph1),
                          ),
                          const SizedBox(height: 40),
                          TabBar(
                            controller: controller.tabcontroller,
                            isScrollable: true,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            indicator: BoxDecoration(
                              color: englishViolet,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            tabs: const <Widget>[
                              Tab(
                                child: Text(
                                  'Fixed Departure',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Custom Departure',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 70.h,
                            child: TabBarView(
                              controller: controller.tabcontroller,
                              children: <Widget>[
                                buildFixedDeparture(),
                                buildCustomDeparture(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  GestureDetector showItinerary(SingleTourController controller) {
    return GestureDetector(
      onTap: () => controller.onViewItineraryClicked(
          controller.singleTour[0].tourData!.itinerary!),
      child: Container(
        height: 60,
        width: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              // height: 57,
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF6F6F6),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.remove_red_eye_rounded,
                  color: englishViolet,
                  size: 25,
                ),
              ),
            ),
            Text(
              'view itinerary',
              style: TextStyle(
                color: englishViolet,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCustomDeparture() {
    return Container();
  }

  Widget buildFixedDeparture() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('   Select Date', style: subheading1),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 50.w,
                      child: dateWheel(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text('Adult'),
                          countOfAdults(),
                          const Text('Children'),
                          countOfChildrens(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Total amount', style: heading3),
                      const Text('Not including GST(5%)'),
                    ],
                  ),
                  Obx(() {
                    return Text(
                      '₹${controller.singleTour[0].packageData?[controller.selectedDateIndex.value].amount}',
                      style: subheading1,
                    );
                  })
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 30),
        Obx(() => CustomButton().showIconButtonWithGradient(
              isLoading: controller.isLoading.value,
              height: 80,
              width: 100.w,
              text: ' Enter Passenger Details',
              onPressed: () => controller.onClickAddPassenger(),
            ))
      ],
    );
  }

  Widget countOfChildrens() {
    return Obx(() {
      return Container(
        width: 100,
        height: 37,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 234, 238),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () => controller.onClickSubtractChildren(),
              child: Container(
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: englishViolet),
                child: const Center(
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
            Text(controller.children.value.toString()),
            GestureDetector(
              onTap: () => controller.onClickAddChildren(),
              child: Container(
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: englishViolet),
                child: const Center(
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget countOfAdults() {
    return Obx(
      () {
        return Container(
          width: 100,
          height: 37,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 234, 238),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () => controller.onClickAdultSubtract(),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: englishViolet),
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
              Text(controller.adult.value.toString()),
              GestureDetector(
                onTap: () => controller.onClickAdultAdd(),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: englishViolet),
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dateWheel() {
    return ListWheelScrollView.useDelegate(
      perspective: 0.009,
      itemExtent: 90,

      // itemCount: controller.singleTour[0].packageData?.length,
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 3,
      //   childAspectRatio: 2,
      //   mainAxisExtent: 40,
      //   mainAxisSpacing: 5,
      // ),
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: controller.singleTour[0].packageData?.length,
        builder: (BuildContext context, int index) {
          final DateTime inputDate = DateTime.parse(
              '${controller.singleTour[0].packageData?[index].dateOfTravel}');
          final DateFormat outputFormat = DateFormat('d MMM yy');
          final String formattedDate = outputFormat.format(inputDate);
          final RxBool isSelected = true.obs;
          isSelected.value = index == controller.selectedDateIndex.value;

          return Text(
            formattedDate,
            style: subheading1,
            textAlign: TextAlign.center,
          );
        },
      ),
      // itemBuilder: (BuildContext context, int index) {
      //   final DateTime inputDate = DateTime.parse(
      //       '${controller.singleTour[0].packageData?[index].dateOfTravel}');
      //   final DateFormat outputFormat = DateFormat('MMM d');
      //   final String formattedDate = outputFormat.format(inputDate);
      //   final RxBool isSelected = true.obs;
      //   isSelected.value = index == controller.selectedDateIndex.value;
      //   return GestureDetector(
      //     onTap: () {
      //       controller.selectedDateIndex.value = index;
      //     },
      //     child: Container(
      //       decoration: BoxDecoration(
      //         color: isSelected.value ? englishViolet : Colors.grey,
      //         borderRadius: BorderRadius.circular(8),
      //       ),
      //       child: Center(
      //         child: Text(
      //           formattedDate,
      //           style: GoogleFonts.montserrat(
      //             fontWeight: FontWeight.w600,
      //             fontSize: 20,
      //             color: isSelected.value ? Colors.white : fontColor,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ),
      //   );
      // },
    );
  }
}
