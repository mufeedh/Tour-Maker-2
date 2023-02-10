import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final getStorage = GetStorage();

  var a = false.obs;
  var b = false.obs;
  var c = false.obs;
  var d = false.obs;
  var e = false.obs;
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

  checkUserLoggedInORnOT() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print("home");
      //home
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.offAllNamed(Routes.HOME),
      );
    } else {
      //login
      print("Login");
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.offAllNamed(Routes.GET_STARTED),
      );
    }
  }
}
