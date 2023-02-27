// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/destinations_model.dart';
import '../../../data/models/package_model.dart';
import '../../../data/repo/category_repo.dart';
import '../../../data/repo/destination_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/filter_screen_view.dart';

class FilterScreenController extends GetxController
    with StateMixin<FilterScreenView> {
  RxList<DestinationsModel> destinationList = <DestinationsModel>[].obs;
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<bool> isSelected = <bool>[].obs;
  RxBool isLoading = false.obs;
  RxBool showDomesticTours = false.obs;
  RxList<bool> isSelectedBudget =
      List<bool>.filled(budgetList.length, false).obs;
  Rx<Budget?> selectedBudget = Rx<Budget?>(null);
  RxInt selectedIndex = 0.obs;
  RxDouble sliderValue = 0.0.obs;
  final RxInt count = 0.obs;
  dynamic selectedDestinationsList;
  List<String> selectedDestinationNames = <String>[];
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
    selectedDestinationsList = selectedDestinations
        .map((DestinationsModel d) => d.destination)
        .join(', ');
    log('Selected destinations: $selectedDestinationsList');
  }

  Future<void> getAllDestinations() async {
    change(null, status: RxStatus.loading());
    final ApiResponse<List<DestinationsModel>> res =
        await DestinationRepository().getAllDestinations();
    try {
      if (res != null) {
        destinationList.value = res.data!;
        isSelected.assignAll(List<bool>.filled(res.data!.length, false));
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      log('catch error $e');
    }
  }

  Future<void> onSelectDestinations() async {
    log('destinations');
    isLoading.value = true;
    change(null, status: RxStatus.loading());

    try {
      final destinations =
          showDomesticTours.value ? true : selectedDestinationsList;
      log('resfd $destinations');

      if (destinations.isNotEmpty == true) {
        // if (res.status == ApiResponseStatus.completed) {
        // final List<PackageModel> data = res.data!;
        log('adeeb fil $destinations');
        Get.toNamed(Routes.TOURS_VIEW, arguments: [destinations]);
        change(null, status: RxStatus.success());
        // } else {
        //   log('empty');
        //   change(null, status: RxStatus.empty());
        // }
      } else {
        Get.snackbar('Nothing selected', 'Select at least one destination',
            backgroundColor: englishViolet, colorText: Colors.white);
        log('hii');
      }
    } catch (e) {
      log('filter screen catch $e');
    }
    isLoading.value = false;
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

  void onFilterDestinations(bool? value, int index) {
    isSelected[index] = value ?? false;

    if (value != null && value) {
      if (selectedDestinations.length < 5) {
        selectedDestinations.add(destinationList[index]);
        final DestinationsModel res = selectedDestinations.last;
        log('last selected destination: $res');
      } else {
        // Automatically remove the first selected item
        final DestinationsModel removedItem = selectedDestinations.removeAt(0);
        isSelected[destinationList.indexOf(removedItem)] = false;
        // Add the newly selected item to the end of the list
        selectedDestinations.add(destinationList[index]);
      }

      // If "Show Domestic Tours" is selected, clear it
      if (showDomesticTours.value) {
        showDomesticTours.value = false;
      }
    } else {
      selectedDestinations.remove(destinationList[index]);
    }

    printSelectedDestinations();
  }

  void onBudgetCheck(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    selectedBudget.value = budgetList[index];
    log(selectedBudget.value!.value);
  }

  // void onBudgetCheck(bool? value, int index) {
  //   if (value == true) {
  //     selectedBudget.value = budgetList[index];
  //   } else {
  //     selectedBudget.value = null;
  //   }
  //   isSelected.assignAll(List.generate(isSelected.length, (i) => i == index));
  // }
}
