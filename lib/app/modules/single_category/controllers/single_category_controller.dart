import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/network_models/package_model.dart';
import '../../../data/models/network_models/wishlist_model.dart';
import '../../../data/repo/network_repo/category_repo.dart';
import '../../../data/repo/network_repo/wishlist_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/single_category_view.dart';

class SingleCategoryController extends GetxController
    with StateMixin<SingleCategoryView> {
  RxList<PackageModel> packageList = <PackageModel>[].obs;
  Rx<String> categoryName = ''.obs;
  Rx<String> categoryImage = ''.obs;
  RxList<WishListModel> wishList = <WishListModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    await getData();
    await getWishList();
  }

  void onSingleTourPressed(PackageModel pckg) {
    Get.toNamed(Routes.SINGLE_TOUR, arguments: <int>[pckg.id!])!
        .whenComplete(() => loadData());
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    if (Get.arguments != null) {
      categoryName.value = Get.arguments[0] as String;
      categoryImage.value = Get.arguments[1] as String;
      log('catname $categoryName');
      await loadCategoryPackages(categoryName.value);
    } else {
      log('no arguments');
    }
  }

  Future<void> getWishList() async {
    final ApiResponse<dynamic> res = await WishListRepo().getAllFav();
    log('ihdiv singlecategory ${res.message}');
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
        final PackageModel package = packageList
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

  Future<void> loadCategoryPackages(String categoryName) async {
    try {
      final ApiResponse<List<PackageModel>> res =
          await CategoryRepository().getCategorybycategoryName(categoryName);
      log('Adeeb categ sts ${res.status}');
      log('Adeeb categ msg ${res.message}');
      log('Adeeb categ  data ${res.data}');
      if (res.status == ApiResponseStatus.completed) {
        if (res.data!.isNotEmpty) {
          packageList.value = res.data!;
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log('catch $e');
    }
  }
}
