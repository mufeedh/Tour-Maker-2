import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../home/views/home_view.dart';

class OtpScreenController extends GetxController with StateMixin {
  CountdownController countDownController = CountdownController();
  TextEditingController textEditorController = TextEditingController();
  var phone;
  var isLoading = false.obs;
  RxString otpCode = ''.obs;
  var verID;
  var forceResendingtoken;
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
  }

  dynamic loadData() {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      verID = Get.arguments[0];
      forceResendingtoken = Get.arguments[1];
      phone = Get.arguments[2];
    }
    change(null, status: RxStatus.success());
  }

  Future<void> signIn() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID.toString(), smsCode: otpCode.toString());
    auth.signInWithCredential(credential).then((UserCredential result) async {
      // String? tok = result.user?.getIdToken(true).toString();
      User user = auth.currentUser!;
      IdTokenResult idTokenResult = await user.getIdTokenResult(true);
      final String token = idTokenResult.token!;

      print('token $token');
      // var hg = tok.val(user.uid);
      // print("tok ${user.getIdTokenResult(true)}");
      // print("tokn ${user.uid}");
      // print("hg${hg}");

      // Get.to(const HomeView(),
      //     arguments: result.user, transition: Transition.leftToRightWithFade);
    });
  }
}
