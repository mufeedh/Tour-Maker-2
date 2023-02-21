import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/booking_tile.dart';
import '../controllers/booking_screen_controller.dart';

// ignore: , strict_raw_type
class BookingScreenView extends GetView<BookingScreenController> {
  const BookingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final BookingScreenController controller =
        Get.put(BookingScreenController());
    return Scaffold(
        extendBody: true,
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
          (dynamic state) => Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17),
                child: Container(
                  height: 60,
                  width: 100.w,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: const Color(0xFFF1F1F1),
                  ),
                  child: TabBar(
                    controller: controller.tabcontroller,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: englishViolet,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
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

  ListView buildCompletedView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => controller.onTapSingleUpComingBooking(),
        child: BookingTile(
          onTapIcon: controller.onTapIcon,
          tourName: 'Kasmmir',
          tourAmount: '12-12-2001',
          tourCode: 'CK2E',
          tourPersons: '8',
          tourAmountCriteria: 'Completed On',
        ),
      ),
    );
  }

  ListView buildCancelledView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => controller.onTapSingleUpComingBooking(),
        child: BookingTile(
          onTapIcon: controller.onTapIcon,
          tourName: 'Kasmmir',
          tourAmount: '500000',
          tourCode: 'CK2E',
          tourPersons: '8',
          tourAmountCriteria: 'Cancelled On',
        ),
      ),
    );
  }

  ListView buildUpcomingView() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => controller.onTapSingleUpComingBooking(),
        child: BookingTile(
          onTapIcon: controller.onTapIcon,
          tourName: 'Kasmmir',
          tourAmount: '500000',
          tourCode: 'CK2E',
          tourPersons: '8',
          tourAmountCriteria: 'Pending Amount',
        ),
      ),
    );
  }
}
