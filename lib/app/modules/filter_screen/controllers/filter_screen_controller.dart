import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreenController extends GetxController with StateMixin {
  var selectedIndex = 0.obs;
  var sliderValue = 0.0.obs;
  final count = 0.obs;
  var values = RangeValues(1, 100).obs;
  var labels = RangeLabels('1', "100").obs;
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
}
