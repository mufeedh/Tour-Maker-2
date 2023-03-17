import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../data/repo/user_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/otp_screen_view.dart';

class OtpScreenController extends GetxController
    with StateMixin<OtpScreenView> {
  CountdownController countDownController = CountdownController();
  TextEditingController textEditorController = TextEditingController();
  GetStorage storage = GetStorage();
  String? phone;
  String? verID;
  int? forceToken;
  RxBool isLoading = false.obs;
  RxString otpCode = ''.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    loadData();
    await SmsAutoFill().listenForCode();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    countDownController.start();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    SmsAutoFill().unregisterListener();
    textEditorController.dispose();
  }

  void loadData() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      verID = Get.arguments[0] as String;
      phone = Get.arguments[1] as String;
      forceToken = Get.arguments[2] as int;
      log('ver id $verID');
      log('phoone $phone');
    }
    change(null, status: RxStatus.success());
  }

  Future<void> signIn() async {
    // try {
    log('sign in otp contr');
    isLoading.value = true;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verID.toString(),
      smsCode: otpCode.toString(),
    );
    await auth
        .signInWithCredential(credential)
        .then((UserCredential result) async {
      //Genrate Token
      final User user = auth.currentUser!;
      final IdTokenResult idTokenResult = await user.getIdTokenResult(true);
      final String token = idTokenResult.token!;
      log('tok$token');
      await storage.write('token', token).then((dynamic value) async {
        checkUserExistsORnot();
      });
      log('token strg ${storage.read('token')}');
    });
  }

  Future<void> onResendinOTP() async {
    log('resend pressed');
    final FirebaseAuth auth = FirebaseAuth.instance;
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      auth.signInWithCredential(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException exception) {
      log('nf adeeb${exception.message}');
    }

    Future<void> codeSent(String verificationId,
        [int? forceResendingToken]) async {}

    void codeAutoRetrievalTimeout(String verificationId) {}

    await auth
        .verifyPhoneNumber(
          phoneNumber: phone.toString(),
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        )
        .then((dynamic value) => Get.toNamed(Routes.OTP_SCREEN));
  }

  Future<void> checkUserExistsORnot() async {
    log('adeeb check user');
    final ApiResponse<Map<String, dynamic>> res =
        await UserRepository().checkUserExists();
    if (res.status == ApiResponseStatus.completed) {
      if (res.data?.isEmpty != true) {
        log('adeeb home');
        putFCM();

        Get.offAllNamed(Routes.HOME);
        isLoading.value = false;
        // Get.offAllNamed(Routes.TOKEN_SCREEN, arguments: token);
      } else {
        log('adeeb login');
        postFcm();

        Get.offAllNamed(Routes.LOGIN, arguments: phone);
        isLoading.value = false;
      }
    } else {
      log('adeeb errrrrrooorr');
    }
  }

  Future<void> putFCM() async {
    log('adeeb put fcm');
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //authorized
      final String? fcmToken = await messaging.getToken();
      final ApiResponse<Map<String, dynamic>> res =
          await UserRepository().putFCMToken(fcmToken);
      if (res.status == ApiResponseStatus.completed) {
      } else {
        log('req not send');
      }
    } else {
      SystemNavigator.pop();
      //not authorized
    }
  }

  Future<void> postFcm() async {
    log('adeeb post fcm');
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //authorized
      final String? fcmToken = await messaging.getToken();
      final ApiResponse<Map<String, dynamic>> res =
          await UserRepository().postFCMToken(fcmToken!);
      if (res.status == ApiResponseStatus.completed) {
      } else {
        log('req not send');
      }
    } else {
      //not authorized
    }
  }
}
