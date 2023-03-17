// ignore_for_file: unnecessary_overrides,

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../main.dart';
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
    log('checking. . . . ');
    try {
      if (currentUser != null) {
        log('adeeb phn ${currentUser?.phoneNumber}');
        currentUserPhoneNumber = currentUser?.phoneNumber;
        log(' user is logged in firebase');
        final String token = await currentUser!.getIdToken(true);
        await getStorage.write('token', token);
        log('adeeb token frm splsh $token');
        sendFCM();
      } else {
        log(' user is not logged in firebase');
        await Get.offAllNamed(Routes.GET_STARTED);
      }
    } catch (e) {
      log('catch $e');
    }
  }

  Future<void> sendFCM() async {
    log('send fcm');
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //authorized
      final String? fcmToken = await messaging.getToken();
      log('fcm $fcmToken');
      final ApiResponse<Map<String, dynamic>> res =
          await UserRepository().putFCMToken(fcmToken);
      if (res.status == ApiResponseStatus.completed) {
        checkUserExistsOnDB();
      } else {
        log('req not send');
      }
    } else {
      //not authorized
    }
  }

  Future<void> checkUserExistsOnDB() async {
    log('check user');
    final ApiResponse<Map<String, dynamic>> res =
        await UserRepository().checkUserExists();
    if (res.status == ApiResponseStatus.completed) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
