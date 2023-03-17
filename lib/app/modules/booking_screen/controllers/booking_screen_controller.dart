// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/booking_model.dart';
import '../../../data/repo/booking_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/booking_screen_view.dart';

class BookingScreenController extends GetxController
    with StateMixin<BookingScreenView>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 3, vsync: this);

  RxList<BookingsModel> upcomingList = <BookingsModel>[].obs;
  RxList<BookingsModel> completedList = <BookingsModel>[].obs;
  RxList<BookingsModel> cancelledList = <BookingsModel>[].obs;

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
    await getAllCompletedBookings();
    await getAllCancelledBookings();
    change(null, status: RxStatus.success());
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
    Get.toNamed(Routes.PAYMENT_SUMMARY)!.whenComplete(() => loadData());
  }

  void onTapIcon() =>
      Get.toNamed(Routes.PASSENGER_DETAILS)!.whenComplete(() => loadData());

  Future<void> getAllUpcomingBookings() async {
    final ApiResponse<List<BookingsModel>> res =
        await BookingRepository().getAllBookings('pending');
    if (res.data != null) {
      upcomingList.value = res.data!;
    }
  }

  Future<void> getAllCompletedBookings() async {
    final ApiResponse<List<BookingsModel>> res =
        await BookingRepository().getAllBookings('completed');

    if (res.data != null) {
      log('adeeb anvar completed ${res.data}');
      completedList.value = res.data!;
    }
  }

  Future<void> getAllCancelledBookings() async {
    final ApiResponse<List<BookingsModel>> res =
        await BookingRepository().getAllBookings('cancelled');

    if (res.data != null) {
      log('adeeb anvar cancelled ${res.data}');
      cancelledList.value = res.data!;
    }
  }
}
