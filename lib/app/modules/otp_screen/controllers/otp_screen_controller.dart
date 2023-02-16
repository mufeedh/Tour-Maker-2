import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      log('ver id $verID');
      log('phoone $phone');
    }
    change(null, status: RxStatus.success());
  }

  Future<void> signIn() async {
    try {
      log('sign in otp contr');
      final FirebaseAuth auth = FirebaseAuth.instance;
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID.toString(),
        smsCode: otpCode.toString(),
      );
      await auth
          .signInWithCredential(credential)
          .then((UserCredential result) async {
        log('auth cred token ${credential.token}');
        log('auth cred accesstok ${credential.accessToken}');
        log('auth cred provider id ${credential.providerId}');
        log('auth cred sign in method ${credential.signInMethod}');
        //Genrate Token
        final User user = auth.currentUser!;
        final IdTokenResult idTokenResult = await user.getIdTokenResult(true);
        final String token = idTokenResult.token!;
        log('tok$token');
        await storage.write('token', token).then((dynamic value) async {
          final ApiResponse<Map<String, dynamic>> res =
              await UserRepository().checkUserExists();
          log('res D${res.data}');
          log('res S${res.status}');
          log('res M${res.message}');
          if (res.status == ApiResponseStatus.completed) {
            Get.offAllNamed(Routes.HOME);
            log('home');
          } else {
            Get.offAllNamed(Routes.LOGIN, arguments: phone);
            log('phne $phone');
          }
        });
        log('token strg ${storage.read('token')}');
      });
    } catch (e) {
      log('jdngjsd $e');
    }
  }

  Future<void> onResendinOTP() async {
    log('resend pressed');
    change(null, status: RxStatus.loading());
    final FirebaseAuth auth = FirebaseAuth.instance;
    void verificationCompleted(AuthCredential phoneAuthCredential) {
      auth.signInWithCredential(phoneAuthCredential);
    }

    void verificationFailed(FirebaseAuthException exception) {
      log('${exception.message}');
    }

    Future<void> codeSent(String verificationId,
        [int? forceResendingToken]) async {
      // Save the verification ID and force resending token for later use
      // Show a dialog to the user to enter the OTP code
    }

    void codeAutoRetrievalTimeout(String verificationId) {
      // Show a dialog to the user to enter the OTP code manually
    }

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
    change(null, status: RxStatus.success());
  }
}
