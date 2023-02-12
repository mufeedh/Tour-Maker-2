// ignore_for_file: unnecessary_overrides, avoid_print, always_specify_types

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final GetStorage getStorage = GetStorage();

  RxBool a = false.obs;
  RxBool b = false.obs;
  RxBool c = false.obs;
  RxBool d = false.obs;
  RxBool e = false.obs;
  @override
  void onInit() {
    super.onInit();

    Timer(const Duration(milliseconds: 400), () {
      a.value = true;
    });
    Timer(const Duration(milliseconds: 400), () {
      b.value = true;
    });
    Timer(const Duration(milliseconds: 1300), () {
      c.value = true;
    });
    Timer(const Duration(milliseconds: 1700), () {
      e.value = true;
      checkUserLoggedInORnOT();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> checkUserLoggedInORnOT() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print('home');
      //home
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.offAllNamed(Routes.HOME),
      );
    } else {
      //login
      print('Login');
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.offAllNamed(Routes.GET_STARTED),
      );
    }
  }
}
