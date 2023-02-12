// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreenController extends GetxController with StateMixin {
  RxInt selectedIndex = 0.obs;
  RxDouble sliderValue = 0.0.obs;
  final RxInt count = 0.obs;
  Rx<RangeValues> values = const RangeValues(1, 100).obs;
  Rx<RangeLabels> labels = const RangeLabels('1', '100').obs;
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
