// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/package_model.dart';
import '../../../data/repo/destination_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/search_details_view.dart';

class SearchDetailsController extends GetxController
    with StateMixin<SearchDetailsView> {
  String? destinationValue;
  RxList<PackageModel> destinations = <PackageModel>[].obs;
  Rx<bool> isClickedFavorites = false.obs;
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
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      destinationValue = Get.arguments as String;
      log('dse');
      try {
        final ApiResponse<List<PackageModel>> res =
            await DestinationRepository()
                .getDestination(destinationValue.toString());
        if (res.status == ApiResponseStatus.completed) {
          destinations.value = res.data!;
          change(null, status: RxStatus.success());
        } else {
          log('empt');
          change(null, status: RxStatus.empty());
        }
      } catch (e) {
        log('search det catch $e');
      }
    } else {}
  }

  void onSingleTourClicked() {}

  Future<void>? onClickFilter() =>
      Get.toNamed(Routes.FILTER_SCREEN)!.whenComplete(() => loadData());

  void onClickFavourites() {
    if (isClickedFavorites.value == true) {
      isClickedFavorites.value = false;
    } else {
      isClickedFavorites.value = true;
    }
  }
}
