import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/booking_tile.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/booking_screen_controller.dart';

// ignore: , strict_raw_type
class BookingScreenView extends GetView<BookingScreenController> {
  const BookingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final BookingScreenController controller =
        Get.put(BookingScreenController());
    return Scaffold(
        // extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Bookings',
            style: TextStyle(color: fontColor),
          ),
        ),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (dynamic state) => Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
                child: Container(
                  height: 60,
                  width: 100.w,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFF1F1F1),
                  ),
                  child: TabBar(
                    controller: controller.tabcontroller,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: englishViolet,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    tabs: const <Widget>[
                      Tab(
                        child: Text(
                          'Upcoming',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Completed',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Cancelled',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TabBarView(
                    controller: controller.tabcontroller,
                    children: <Widget>[
                      buildUpcomingView(),
                      buildCompletedView(),
                      buildCancelledView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildCompletedView() {
    return Obx(() {
      return Container(
        child: controller.completedList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.completedList.length,
                itemBuilder: (BuildContext context, int index) {
                  final int totalTravellers =
                      controller.completedList[index].noOfAdults! +
                          controller.completedList[index].noOfChildren!;
                  return GestureDetector(
                    onTap: () => controller.onTapSingleUpComingBooking(),
                    child: BookingTile(
                      onTapIcon: controller.onTapIcon,
                      bm: controller.completedList[index],
                      totalTravellers: totalTravellers.toString(),
                    ),
                  );
                })
            : const CustomErrorScreen(errorText: 'No Completed \n bookings '),
      );
    });
  }

  Widget buildCancelledView() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: controller.loadData,
        color: englishViolet,
        child: controller.cancelledList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.cancelledList.length,
                itemBuilder: (BuildContext context, int index) {
                  final int totalTravellers =
                      controller.cancelledList[index].noOfAdults! +
                          controller.cancelledList[index].noOfChildren!;
                  return GestureDetector(
                    onTap: () => controller.onTapSingleUpComingBooking(),
                    child: BookingTile(
                      onTapIcon: controller.onTapIcon,
                      bm: controller.cancelledList[index],
                      totalTravellers: totalTravellers.toString(),
                    ),
                  );
                })
            : const CustomErrorScreen(errorText: 'No Cancelled \n bookings'),
      );
    });
  }

  Widget buildUpcomingView() {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: controller.loadData,
        color: englishViolet,
        child: controller.upcomingList.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.upcomingList.length,
                itemBuilder: (BuildContext context, int index) {
                  final int totalTravellers =
                      controller.upcomingList[index].noOfAdults! +
                          controller.upcomingList[index].noOfChildren!;
                  return GestureDetector(
                    onTap: () => controller.onTapSingleUpComingBooking(),
                    child: BookingTile(
                      onTapIcon: controller.onTapIcon,
                      bm: controller.upcomingList[index],
                      totalTravellers: totalTravellers.toString(),
                    ),
                  );
                })
            : const CustomErrorScreen(errorText: 'No Upcoming\n bookings'),
      );
    });
  }
}
