import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/theme/style.dart';
import '../../../data/models/local_model/recent_search_mode.dart';
import '../../../routes/app_pages.dart';
import '../views/search_view_view.dart';

class SearchViewController extends GetxController
    with StateMixin<SearchViewView> {
  final TextEditingController textController = TextEditingController();
  final RxList<RecentSearch> recentSearches = <RecentSearch>[].obs;

  RxString searchValue = ''.obs;
  final GetStorage storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadRecentSearchesFromStorage();
  }

  @override
  void onClose() {
    super.onClose();
    textController.dispose();
  }

  Future<void> onSubmitSearch(String value) async {
    change(null, status: RxStatus.loading());
    if (value != null || value.isNotEmpty) {
      searchValue.value = value;
      final RecentSearch search =
          RecentSearch(keyword: searchValue.value.trim());
      final int existingIndex = recentSearches
          .indexWhere((RecentSearch s) => s.keyword == search.keyword);
      if (existingIndex >= 0) {
        // Move the existing search to the top of the list
        recentSearches.removeAt(existingIndex);
        recentSearches.insert(0, search);
      } else {
        // Add the new search to the top of the list
        recentSearches.insert(0, search);
      }
      storage.write(
          'recentSearches',
          recentSearches
              .map((RecentSearch search) => search.toJson())
              .toList());

      await Get.toNamed(Routes.SEARCH_DETAILS,
              arguments: searchValue.value.trim())!
          .whenComplete(() => loadRecentSearchesFromStorage());
      change(null, status: RxStatus.success());
    } else {
      Get.snackbar('Please enter a destination', '',
          backgroundColor: englishViolet, colorText: Colors.white);
    }
  }

  Future<void> loadRecentSearchesFromStorage() async {
    change(null, status: RxStatus.loading());
    final List<dynamic>? recentSearchesJson =
        storage.read('recentSearches') as List<dynamic>?;
    if (recentSearchesJson != null) {
      recentSearches.assignAll(recentSearchesJson
          .map((dynamic json) =>
              RecentSearch.fromJson(json as Map<String, dynamic>))
          .toList());
    }
    change(null, status: RxStatus.success());
  }

  void onClickBack() {
    Get.toNamed(Routes.HOME)!
        .whenComplete(() => loadRecentSearchesFromStorage());
  }

  void onClickClearTextfIeld() => textController.clear();

  void onClickDeleteSuggestion(int index) {
    recentSearches.removeAt(index);
    storage.write('recentSearches', recentSearches.toList(growable: false));
  }
}
