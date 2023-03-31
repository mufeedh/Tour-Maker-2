import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/checkout_model.dart';

class CheckoutScreenController extends GetxController with StateMixin {
  CheckOutModel? checkOutModel;
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

  loadData() {
    if (Get.arguments != null) {
      checkOutModel = Get.arguments as CheckOutModel;
    } else {}
  }

  int getTotalAmount() {
    final int adultCount = checkOutModel!.adultCount!;
    final int chidrenCount = checkOutModel!.childrenCount!;
    final int adultAmount = checkOutModel!.offerAmount != null
        ? checkOutModel!.offerAmount! * adultCount
        : checkOutModel!.amount! * adultCount;
    final int kidsAmount = checkOutModel!.kidsOfferAmount != null
        ? checkOutModel!.kidsOfferAmount! * chidrenCount
        : checkOutModel!.kidsAmount! * chidrenCount;
    final int totalAmount = adultAmount + kidsAmount;
    return totalAmount;
  }

  double getGST() {
    final int totalAmount = getTotalAmount();
    final double gst = (totalAmount * checkOutModel!.gst!) / 100;
    return gst;
  }

  double getSGST() {
    final int totalAmount = getTotalAmount();
    final double sgstpercentage = checkOutModel!.gst! / 2;
    final double sgst = (totalAmount * sgstpercentage) / 100;
    return sgst;
  }

  double getCGST() {
    final int totalAmount = getTotalAmount();
    final double cgstPercentage = checkOutModel!.gst! / 2;
    final double sgst = (totalAmount * cgstPercentage) / 100;
    return sgst;
  }

  double getTotalAmounttoBePaid() {
    final double gst = getGST();

    final int totalAmount = getTotalAmount();
    final double sum = totalAmount + gst;
    return sum;
  }

  int getCommissionAmount() {
    int commission = checkOutModel!.commission!;
    int totalPassenegrs = getTotalPassengers();
    int sum = commission * totalPassenegrs;
    return sum;
  }

  int getTotalPassengers() {
    int totalPassenegrs =
        checkOutModel!.adultCount! + checkOutModel!.childrenCount!;
    return totalPassenegrs;
  }

  double getGrandTotal() {
    int commission = getCommissionAmount();
    var totalAmount = getTotalAmounttoBePaid();
    double grandTotal = totalAmount - commission;
    return grandTotal;
  }
}
