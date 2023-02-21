import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/single_tour_view.dart';

class SingleTourController extends GetxController
    with StateMixin<SingleTourView>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 2, vsync: this);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onTapFixedDeparture() {
    tabcontroller.animateTo(1);
  }

  void onTapCustomDeparture() {
    tabcontroller.animateTo(1);
  }

  onClickedAdd() {}
}
