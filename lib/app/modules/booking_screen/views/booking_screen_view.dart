import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../controllers/booking_screen_controller.dart';

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
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 37),
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
                      child: Text('Upcoming'),
                    ),
                    Tab(
                      child: Text('Completed'),
                    ),
                    Tab(
                      child: Text('Cancelled'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(36),
                  ),
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
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          // width: 50,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            trailing: Wrap(
              spacing: 5, // space between two icons
              children: <Widget>[
                Icon(TourMaker.people, color: englishViolet),
                const Text('5')
              ],
            ),
            title: const Text(
              'KashMir Tour',
            ),
            subtitle: const Text('CK2D'),
          ),
        ),
      ),
    );
  }

  ListView buildCancelledView() {
    return ListView.builder(
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          // width: 50,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            trailing: Icon(TourMaker.people, color: englishViolet),
            title: const Text('KashMir Tour'),
            subtitle: const Text('CK2D'),
          ),
        ),
      ),
    );
  }

  ListView buildUpcomingView() {
    return ListView.builder(
      itemCount: 115,
      itemBuilder: (BuildContext context, int index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          // width: 50,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            style: ListTileStyle.drawer,
            trailing: Icon(TourMaker.people, color: englishViolet),
            title: const Text('KashMir Tour'),
            subtitle: Text('pendiing amt:', style: paragraph2),
          ),
        ),
      ),
    );
  }
}
