// ignore_for_file: unnecessary_overrides,

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/repo/user_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';

class SplashScreenController extends GetxController with StateMixin<dynamic> {
  final GetStorage getStorage = GetStorage();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Rx<bool> isInternetConnect = true.obs;
  // RxBool a = false.obs;
  // RxBool b = false.obs;
  // RxBool c = false.obs;
  // RxBool d = false.obs;
  // RxBool e = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    // // change(null, status: RxStatus.success());
    // log('df');
    // await checkUserLoggedInORnOT();
    isInternetConnectFunction();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    // print('dsf');
    log('re');
    await checkUserLoggedInORnOT();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> isInternetConnectFunction() async {
    log('inernet');
    isInternetConnect.value = await InternetConnectionChecker().hasConnection;
    isInternetConnect.value != true
        ? Get.toNamed(Routes.NOINTERNET)
        : checkUserLoggedInORnOT();
  }

  Future<void> checkUserLoggedInORnOT() async {
    try {
      if (currentUser != null) {
        log(' user is logged in firebase');
        // await isInternetConnectFunction();

        final String token = await currentUser!.getIdToken(true);
        //generating token

        await getStorage.write('token', token);
        final ApiResponse<Map<String, dynamic>> res =
            await UserRepository().checkUserExists();
        log('check on DB');
        if (res.status == ApiResponseStatus.completed) {
          log('statuscodde==200');
          if (res.data?.isEmpty != true) {
            // await Get.offAllNamed(Routes.TOKEN_SCREEN, arguments: token);

            log('on DB result:{"""data"""}');
            await Get.offAllNamed(Routes.HOME);
          } else {
            log('on DB result:{}');
            await Get.offAllNamed(Routes.LOGIN,
                arguments: currentUser?.phoneNumber);
          }
        }
      } else {
        log('user is not logged in');
        await Get.offAllNamed(Routes.GET_STARTED);
      }
    } catch (e) {
      log('catch $e');
    }
  }
}
