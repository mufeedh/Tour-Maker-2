// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/single_booking_model.dart';
import '../../../data/repo/booking_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/payment_summary_view.dart';

class PaymentSummaryController extends GetxController
    with StateMixin<PaymentSummaryView> {
  RxList<SingleBookingModel> bookingList = <SingleBookingModel>[].obs;
  int? id;
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

  void loadData() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      id = Get.arguments as int;
      log('sfg $id');
      loadBookingDetails(id!);
    }
  }

  Future<void> loadBookingDetails(int id) async {
    final ApiResponse<List<SingleBookingModel>> res =
        await BookingRepository().getSingleBooking(id);
    if (res.data != null) {
      bookingList.value = res.data!;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  int getTotalTravellersCount() {
    final int sum = bookingList[0].noOfAdults! + bookingList[0].noOfKids!;
    return sum;
  }

  num getRemainingAmount() {
    final num sum = bookingList[0].payableAmount! - bookingList[0].amountPaid!;
    return sum;
  }

  onClickPassengers(int? id) {
    Get.toNamed(Routes.TRAVELLERS_SCREEN, arguments: id)!
        .whenComplete(() => loadData());
  }
}
