// ignore_for_file: unnecessary_overrides,

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repo/user_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';

class SplashScreenController extends GetxController with StateMixin {
  final GetStorage getStorage = GetStorage();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // RxBool a = false.obs;
  // RxBool b = false.obs;
  // RxBool c = false.obs;
  // RxBool d = false.obs;
  // RxBool e = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
    log('df');
    await checkUserLoggedInORnOT();
  }

  @override
  void onReady() async {
    super.onReady();
    // // print('dsf');
    // await checkUserLoggedInORnOT();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> checkUserLoggedInORnOT() async {
    log('CHECKING . . . . ');

    if (currentUser != null) {
      log('USER EXISTS ON FIREBASE');
      final String token = await currentUser!.getIdToken(true);
      log('tokken $token');
      await getStorage.write('token', token);
      final ApiResponse<Map<String, dynamic>> res =
          await UserRepository().checkUserExists();
      if (res.status == ApiResponseStatus.completed) {
        log('USER EXISTS ON DB');
        Get.offAllNamed(Routes.HOME);
        // Get.offAllNamed(Routes.TOKEN_SCREEN, arguments: token);
      } else {
        Get.offAllNamed(Routes.LOGIN);
        log('USER SIGNED IN FIREBASE');
      }
    } else {
      log('NEW USER');
      Get.offAllNamed(Routes.GET_STARTED);
    }
  }
}
