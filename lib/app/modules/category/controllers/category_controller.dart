import 'dart:developer';

import 'package:get/get.dart';
import '../../../data/models/category_model.dart';
import '../../../data/repo/category_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/category_view.dart';

class CategoryController extends GetxController with StateMixin<CategoryView> {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxBool isSelected = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
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
}
