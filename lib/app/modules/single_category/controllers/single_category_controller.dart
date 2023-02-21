import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/single_category_model.dart';
import '../../../data/repo/category_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';

class SingleCategoryController extends GetxController with StateMixin {
  RxList<SingleCategoryModel> singleCategoryList = <SingleCategoryModel>[].obs;
  String? categoryName;
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

  void loadData() async {
    await getData();
    loadOffers();
  }

  onSingleTourPressed() {
    Get.toNamed(Routes.SINGLE_TOUR);
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      categoryName = Get.arguments as String;
      log('catname $categoryName');
      try {
        change(null, status: RxStatus.loading());

        final ApiResponse<List<SingleCategoryModel>> res =
            await CategoryRepository().getCategorybycategoryName(categoryName!);
        if (res.status == ApiResponseStatus.completed) {
          singleCategoryList.value = res.data!;
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } catch (e) {
        log('catch $e');
      }
    } else {
      log('no arguments');
    }
  }

  void loadOffers() {
    // if () {

    // } else {

    // }
  }
}
