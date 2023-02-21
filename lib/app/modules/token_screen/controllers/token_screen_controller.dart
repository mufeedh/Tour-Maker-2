// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenScreenController extends GetxController with StateMixin<dynamic> {
  String? tok;
  final RxInt count = 0.obs;

  GetStorage getstorage = GetStorage();
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

  void increment() => count.value++;

  void loadData() async {
    log('1');
    change(null, status: RxStatus.loading());

    if (Get.arguments != null) {
      log('2');
      tok = Get.arguments as String;
      // tok.value = res;
      log('hi $tok');
      change(null, status: RxStatus.success());
    } else {
      // change(null, status: RxStatus.loading());

      // tok = token;
      tok = await getstorage.read('token');
      log('hbsdfj');
      // change(null, status: RxStatus.success());
    }
  }
}
