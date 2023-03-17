// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/package_model.dart';
import '../../../routes/app_pages.dart';
import '../views/tours_view_view.dart';

class ToursViewController extends GetxController
    with StateMixin<ToursViewView> {
  // var data;
  List<PackageModel> dataList = <PackageModel>[];
  Rx<bool> isFavorite = false.obs;
  Rx<bool> isHaveOffer = false.obs;
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
      dataList = Get.arguments as List<PackageModel>;
      log('adeeb tour $dataList');
      log('adeeb tour da ${dataList[0]}');
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> onClickSingleTour(int id) async {
    Get.toNamed(Routes.SINGLE_TOUR, arguments: <int>[id])!
        .whenComplete(() => loadData());
  }

  void onClickFavourites(PackageModel dataList) {}

  // Future<void> getData(var data) async {
  //   final ApiResponse<List<PackageModel>> res =
  //       await DestinationRepository().getDestination(data.toString());
  //   if (res.status == ApiResponseStatus.completed) {
  //     dataList.value = res.data!;
  //     change(null, status: RxStatus.success());
  //   } else {
  //     change(null, status: RxStatus.empty());
  //   }
  // }
}
