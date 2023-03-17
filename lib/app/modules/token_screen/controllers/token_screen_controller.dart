// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenScreenController extends GetxController
    with StateMixin<dynamic>, GetSingleTickerProviderStateMixin {
  String? tok;
  String? fcmtok;
  late TabController tabController;

  GetStorage getstorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadData();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  Future<void> loadData() async {
    log('1');
    change(null, status: RxStatus.loading());

    if (Get.arguments != null) {
      log('2');
      tok = Get.arguments[0] as String;
      fcmtok = Get.arguments[1] as String;
      await getstorage.write('fcmtok', fcmtok);
      // tok.value = res;
      log('hi $tok');
      change(null, status: RxStatus.success());
    } else {
      // change(null, status: RxStatus.loading());

      // tok = token;
      tok = getstorage.read('token');
      fcmtok = getstorage.read('fcmtok');
      log('hbsdfj');
      // change(null, status: RxStatus.success());
    }
  }
}
