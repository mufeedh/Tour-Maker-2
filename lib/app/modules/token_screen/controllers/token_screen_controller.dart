// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';

class TokenScreenController extends GetxController with StateMixin {
  String? tok;
  final RxInt count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void loadData() {
    log('1');
    if (Get.arguments != null) {
      change(null, status: RxStatus.loading());
      log('2');
      tok = Get.arguments as String;
      // tok.value = res;
      log('hi $tok');
      change(null, status: RxStatus.success());
    } else {
      // tok = token;
      log('hbsdfj');
    }
  }
}
