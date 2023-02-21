// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SearchViewController extends GetxController {
  final TextEditingController textController = TextEditingController();
  var searchValue;
  RxList suggestions = [].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSubmitSearch(String value) async {
    searchValue = value;
    // if (value.isEmpty != true) {

    // } else {
    //   log('nop');
    // }

    await Get.toNamed(Routes.SEARCH_DETAILS, arguments: searchValue);
  }

  void onClickBack() => Get.back();

  void onClickClearTextfIeld() => textController.clear();

  onClickDeleteSuggestion() {}
}

class SearchModel {
  SearchModel({this.searchText});
  String? searchText;
}
