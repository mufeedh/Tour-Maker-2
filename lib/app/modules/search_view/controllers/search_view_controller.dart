// ignore_for_file: unnecessary_overrides

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/recent_searchmodel.dart';
import '../../../routes/app_pages.dart';
import '../views/search_view_view.dart';

class SearchViewController extends GetxController
    with StateMixin<SearchViewView> {
  final TextEditingController textController = TextEditingController();
  final RxList<RecentSearch> recentSearches =
      RxList<RecentSearch>(<RecentSearch>[]);
  String? searchValue;
  final GetStorage storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadRecentSearchesFromStorage();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onSubmitSearch(String value) async {
    searchValue = value;
    change(null, status: RxStatus.loading());

    final String jsonString = '{"keyword":"$searchValue"}';
    final Map<String, dynamic> jsonMap =
        jsonDecode(jsonString) as Map<String, dynamic>;
    final RecentSearch search = RecentSearch.fromJson(jsonMap);
    // Check if the search is already in the list
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
    storage.write('recentSearches', recentSearches.toList(growable: true));

    await Get.toNamed(Routes.SEARCH_DETAILS, arguments: searchValue);
    change(null, status: RxStatus.success());
  }

  Future<void> loadRecentSearchesFromStorage() async {
    change(null, status: RxStatus.loading());
    final List<dynamic> recentSearchesValue =
        storage.read<List<dynamic>>('recentSearches') ?? <dynamic>[];
    recentSearches.assignAll(recentSearchesValue
        // ignore: always_specify_types
        .map((search) => search is Map<dynamic, dynamic>
            ? Map<String, dynamic>.from(search)
            : null)
        .where((Map<String, dynamic>? jsonMap) => jsonMap != null)
        .map((Map<String, dynamic>? jsonMap) => RecentSearch.fromJson(jsonMap!))
        .toList());
    change(null, status: RxStatus.success());
  }

  void onClickBack() {
    Get.toNamed(Routes.MAIN_SCREEN);
  }

  void onClickClearTextfIeld() => textController.clear();

  void onClickDeleteSuggestion(int index) {
    recentSearches.removeAt(index);
    storage.write('recentSearches', recentSearches.toList(growable: false));
  }

  void onClickSuggestion(String keyword) {}
}
