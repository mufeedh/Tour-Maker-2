// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../core/theme/style.dart';
import '../../../routes/app_pages.dart';

class NointernetController extends GetxController {
  Rx<bool> isLoading = false.obs;
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

  Future<void> checkConnection() async {
    isLoading.value = true;
    if (await InternetConnectionChecker().hasConnection == true) {
      Get.offAllNamed(Routes.SPLASH_SCREEN);
      isLoading.value = false;
    } else {
      Get.snackbar(
        'No Internet',
        'Check Your Connection',
        backgroundColor: englishViolet,
        colorText: Colors.white,
      );
      isLoading.value = false;
    }
  }
}
