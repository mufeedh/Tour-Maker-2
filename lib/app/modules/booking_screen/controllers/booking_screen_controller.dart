// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../views/booking_screen_view.dart';

class BookingScreenController extends GetxController
    with StateMixin<BookingScreenView>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 3, vsync: this);
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadData() async {
    await getAllUpcomingBookings();
  }

  void onTapUpcoming() {
    tabcontroller.animateTo(1);
  }

  void onTapCompleted() {
    tabcontroller.animateTo(1);
  }

  void onTapCancelled() {
    tabcontroller.animateTo(1);
  }

  void onTapSingleUpComingBooking() {
    Get.toNamed(Routes.PAYMENT_SUMMARY);
  }

  void onTapIcon() => Get.toNamed(Routes.PASSENGER_DETAILS);

  Future<void> getAllUpcomingBookings() async {}
}
