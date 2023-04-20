// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/network_models/package_model.dart';
import '../../../data/models/network_models/wishlist_model.dart';
import '../../../data/repo/network_repo/wishlist_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/tours_view_view.dart';

class ToursViewController extends GetxController
    with StateMixin<ToursViewView> {
  List<PackageModel> dataList = <PackageModel>[];
  RxList<WishListModel> wishList = <WishListModel>[].obs;
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

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      dataList = Get.arguments as List<PackageModel>;
      await getWishList();
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

  Future<void> getWishList() async {
    final ApiResponse<dynamic> res = await WishListRepo().getAllFav();
    log('ihdiv wish tours vierw${res.message}');
    if (res.data != null) {
      wishList.value = res.data! as List<WishListModel>;
    } else {}
  }

  Future<void> toggleFavorite(int productId) async {
    log('kumbalangi  toggled');
    try {
      final bool isInWishList =
          wishList.any((WishListModel package) => package.id == productId);
      if (isInWishList) {
        await WishListRepo().deleteFav(productId);
        wishList
            .removeWhere((WishListModel package) => package.id == productId);
        log('kumbalangi isinWishlist =true ');
      } else {
        await WishListRepo().createFav(productId);
        // final PackageModel package = singleCategoryList
        //     .firstWhere((PackageModel package) => package.id == productId);
        // wishlists.add(package as WishListModel);
        final PackageModel package = dataList
            .firstWhere((PackageModel package) => package.id == productId);
        final WishListModel wishlistItem = WishListModel(
          id: package.id,
          name: package.name,
          // add any other properties that are required for the wishlist item
        );
        wishList.add(wishlistItem);

        log('kumbalangi  isinwishlist nott true');
      }
    } catch (e) {
      log('kumbalangi  Error toggling favorite: $e');
    }
  }

  RxBool isFavorite(int productId) =>
      RxBool(wishList.any((WishListModel package) => package.id == productId));
}
