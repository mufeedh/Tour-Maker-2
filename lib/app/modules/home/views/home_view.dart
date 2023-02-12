import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../booking_screen/views/booking_screen_view.dart';
import '../../favourites_screen/views/favourites_screen_view.dart';
import '../../main_screen/views/main_screen_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
        body: PageView(
          controller: controller.pageViewController,
          onPageChanged: (int value) => controller.onPageViewChanged(value),
          children: getScreens(),
        ),
        bottomNavigationBar: Obx(() => bottomNavigationBar()));
  }

  CurvedNavigationBar bottomNavigationBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      animationCurve: Curves.ease,
      buttonBackgroundColor: backgroundColor,
      index: controller.currentIndex.value,
      onTap: (int index) => controller.onTapNavigationBar(index),
      items: const <Widget>[
        Icon(TourMaker.group_32),
        Icon(TourMaker.heart),
        Icon(TourMaker.ticket),
        Icon(TourMaker.profile_icon),
      ],
    );
  }

  List<StatelessWidget> getScreens() {
    return <StatelessWidget>[
      const MainScreenView(),
      const FavouritesScreenView(),
      const BookingScreenView(),
      const ProfileView(),
    ];
  }
}
