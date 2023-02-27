// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/single_tour_model.dart';
import '../../../data/repo/singletourrepo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/single_tour_view.dart';

class SingleTourController extends GetxController
    with StateMixin<SingleTourView>, GetSingleTickerProviderStateMixin {
  late final TabController tabcontroller =
      TabController(length: 2, vsync: this);
  int? tourID;
  Rx<SingleTourModel> tourList = SingleTourModel().obs;
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

  void onTapFixedDeparture() {
    tabcontroller.animateTo(1);
  }

  void onTapCustomDeparture() {
    tabcontroller.animateTo(1);
  }

  void onClickedAdd() {}

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      tourID = Get.arguments[0] as int;
      loadSingleTourData(tourID!);
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> loadSingleTourData(int tourID) async {
    change(null, status: RxStatus.loading());

    final ApiResponse<SingleTourModel> res =
        await SingleTourRepository().getSingleTour(tourID);
    log('adeeb rep ${res.message}');
    log('adeeb rep ${res.status}');

    if (res.status == ApiResponseStatus.completed) {
      tourList.value = res.data!;
      change(null, status: RxStatus.success());
    } else {}
  }
}
