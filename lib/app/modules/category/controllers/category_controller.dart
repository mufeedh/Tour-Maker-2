import 'dart:developer';

import 'package:get/get.dart';
import 'package:tour_maker/app/data/repo/category_repo.dart';

class CategoryController extends GetxController with StateMixin {
  var categoryList = [].obs;
  var isSelected = false.obs;
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

  loadData() async {
    change(null, status: RxStatus.loading());
    var res = await CategoryRepository().getAllCategory();

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
}
