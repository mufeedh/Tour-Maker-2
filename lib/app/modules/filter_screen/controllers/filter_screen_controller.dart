// ignore_for_file: unnecessary_overrides

import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/destinations_model.dart';
import '../../../data/repo/category_repo.dart';
import '../../../data/repo/destination_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/filter_screen_view.dart';

class FilterScreenController extends GetxController
    with StateMixin<FilterScreenView> {
  RxList<DestinationsModel> destinationList = <DestinationsModel>[].obs;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<bool> isSelected = <bool>[].obs;
  RxInt selectedIndex = 0.obs;
  RxDouble sliderValue = 0.0.obs;
  final RxInt count = 0.obs;
  // Rx<RangeValues> values = const RangeValues(1, 100).obs;
  // Rx<RangeLabels> labels = const RangeLabels('1', '100').obs;
  // List<bool> checked = <bool>[];
  // List<DestinationsModel> selectedDestinations = [];
  List<String> selectedDestinationNames = [];
  List<DestinationsModel> selectedDestinations = <DestinationsModel>[];

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
    await getAllDestinations();
    await getAllCategories();
  }

  Future<void> getAllCategories() async {
    change(null, status: RxStatus.loading());
    final ApiResponse<List<CategoryModel>> res =
        await CategoryRepository().getAllCategory();

    try {
      if (res != null) {
        categoryList.value = res.data!;

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      log('catch error $e');
    }
  }

  void printSelectedDestinations() {
    var selectedDestinationsList =
        selectedDestinations.map((d) => d.destination).join(', ');

    log('Selected destinations: $selectedDestinationsList');
  }

  Future<void> getAllDestinations() async {
    change(null, status: RxStatus.loading());
    final ApiResponse<List<DestinationsModel>> res =
        await DestinationRepository().getAllDestinations();
    try {
      if (res != null) {
        destinationList.value = res.data!;
        isSelected.assignAll(List.filled(res.data!.length, false));
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      log('catch error $e');
    }
  }

  void onSelectDestinations() {
    log('destinations');
  }

  void onSelectBudget() {
    log('budget');
  }

  void onSelectedCategory() {
    log('category');
  }

  void onSelectDuration() {
    log('duration');
  }
}
