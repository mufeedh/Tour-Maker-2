// ignore_for_file: strict_raw_type, always_specify_types

import 'dart:developer';

import 'package:get/get.dart';
import '../../../data/models/wishlist_model.dart';
import '../../../data/repo/wishlist_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';

class FavouritesScreenController extends GetxController with StateMixin {
  RxList<WishListModel> wishList = <WishListModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
    log('load');
  }

  Future<void> onSingleTourPressed() async =>
      await Get.toNamed(Routes.SINGLE_TOUR);

  Future<void> loadData() async {
    log('kopa');
    change(null, status: RxStatus.loading());
    try {
      final res = await WishListRepo().getAllFav();
      if (res.status == ApiResponseStatus.completed) {
        log('cdsc');
        wishList.value = res.data!;
        log('jbfidfwefc ${wishList.length}');
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
        log('nop');
      }
    } catch (e) {
      log('catch error $e');
    }
  }
}
// 5 beef bir
// 5 meen fry 
// 4 chick fry
