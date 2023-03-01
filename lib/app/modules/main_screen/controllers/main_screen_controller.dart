// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/trending_tours.dart';
import '../../../data/repo/category_repo.dart';
import '../../../data/repo/trending_tours_rep.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../../../widgets/custom_search_delegate.dart';
import '../views/main_screen_view.dart';

class MainScreenController extends GetxController
    with StateMixin<MainScreenView> {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<TrendingToursModel> trendingToursList = <TrendingToursModel>[].obs;

  TextEditingController textController = TextEditingController();
  MyCustomSearchDelegate delegate = MyCustomSearchDelegate();
  final FocusNode searchFocusNode = FocusNode();
  int counter = 0;

  @override
  void onInit() {
    super.onInit();
    loadData();
    log('jn');
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
    log('laopd');
    change(null, status: RxStatus.loading());
    await getCategory();
    await getTrending();
  }

  Future<void> getCategory() async {
    log('get cate');
    change(null, status: RxStatus.loading());
    await CategoryRepository()
        .getAllCategory()
        .then((ApiResponse<List<CategoryModel>> res) async {
      log('Adeeb ${res.data}');
      if (res.status == ApiResponseStatus.completed) {
        categoryList.value = res.data!;
        log('cygd ${categoryList.length}');
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        log('err ');
      }
    });
  }

  void onNotificationsClicked() {}

  void onClickedCategory(int index) {}

  void onClickedSingleCategory(String name, String image) {
    Get.toNamed(Routes.SINGLE_CATEGORY, arguments: <String>[name, image])!
        .whenComplete(() => loadData());
  }

  Future<void> getTrending() async {
    change(null, status: RxStatus.loading());
    await TrendingToursRepository()
        .getAllTrendingTours()
        .then((ApiResponse<List<TrendingToursModel>> res) {
      if (res.data != null) {
        trendingToursList.value = res.data!;
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    });
  }

  void onSearchClicked() {
    searchFocusNode.unfocus();
    change(null, status: RxStatus.loading());
    Get.toNamed(Routes.SEARCH_VIEW)!.whenComplete(() => loadData());
    change(null, status: RxStatus.success());
  }
}
