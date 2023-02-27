import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/single_category_model.dart';
import '../../../data/models/wishlist_model.dart';
import '../../../data/repo/category_repo.dart';
import '../../../data/repo/wishlist_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/single_category_view.dart';

class SingleCategoryController extends GetxController
    with StateMixin<SingleCategoryView> {
  RxList<SingleCategoryModel> singleCategoryList = <SingleCategoryModel>[].obs;
  Rx<String> categoryName = ''.obs;
  Rx<String> categoryImage = ''.obs;
  Rx<bool> isHaveOffer = false.obs;
  Rx<bool> isClickedFavorites = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    await getData();
    loadOffers();
  }

  void onSingleTourPressed(int id) {
    Get.toNamed(Routes.SINGLE_TOUR, arguments: <int>[id]);
  }

  Future<void> getData() async {
    if (Get.arguments != null) {
      categoryName.value = Get.arguments[0] as String;
      categoryImage.value = Get.arguments[1] as String;
      log('catname $categoryName');
      try {
        change(null, status: RxStatus.loading());

        final ApiResponse<List<SingleCategoryModel>> res =
            await CategoryRepository().getCategorybycategoryName(categoryName);
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
  Future<void> onClickFavourites(int index) async {
    final tourId = singleCategoryList[index].tourId!;
    final ApiResponse<List<WishListModel>> res =
        await WishListRepo().createFav(tourId);

    if (res.status == ApiResponseStatus.completed) {
      isClickedFavorites.value = true;
    } else {
      isClickedFavorites.value = false;
    }
  }
}
