// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class PaymentScreenController extends GetxController
    with StateMixin<dynamic>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 3, vsync: this);
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  void onTapSingleProcessingPayment() => Get.toNamed(Routes.PAYMENT_SUMMARY);

  void onTapIcon() {}

  void onTapSinglePendingPayment() {
    Get.toNamed(Routes.PAYMENT_SUMMARY);
  }

  void onTapSinglePaidView() {}
}
