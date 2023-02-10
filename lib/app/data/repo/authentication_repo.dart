import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class AuthenticationRepository extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? _uid;
  String get uid => _uid!;
//get OTP with phn number
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    String phnNum = phoneNumber;
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            Get.snackbar("Err", "Network error");
          },
          codeSent: (verificationId, forceResendingToken) {
            Get.toNamed(Routes.OTP_SCREEN, arguments: [verificationId, phnNum]);
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      Get.snackbar("context", e.message.toString());
    }
  }

//Verify phn number with otp

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await auth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("context", e.message.toString());
    }
  }
}
