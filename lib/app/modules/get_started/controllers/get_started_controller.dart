// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/theme/style.dart';
import '../../../routes/app_pages.dart';

class GetStartedController extends GetxController with StateMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GetStorage storage = GetStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  int? verificationId;
  int? otp;
  RxBool isButtonVisible = true.obs;
  RxBool isloading = false.obs;
  RxString authStatus = ''.obs;
  String? phone;
  var verificationid;
  Rx<Country> selectedCountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  ).obs;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onCountryCodeClicked(BuildContext context) {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
          backgroundColor: Colors.white,
          bottomSheetHeight: 500,
          textStyle: subheading1),
      context: context,
      onSelect: (Country value) => selectedCountry.value = value,
    );
  }

  Future<void> onVerifyPhoneNumber() async {
    if (formKey.currentState!.validate()) {
      log('valid');
      try {
        final String phoneNumber = '+${selectedCountry.value.phoneCode}$phone';
        final FirebaseAuth auth = FirebaseAuth.instance;
        await auth
            .verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential authCredential) async {
            isloading.value = true;
            log('verification completed');
            auth.signInWithCredential(authCredential);
            log('auth cred token ${authCredential.token}');
            log('auth cred smscode${authCredential.smsCode}');
            log('auth cred verif ${authCredential.verificationId}');
            verificationid = authCredential.verificationId;
            log('auth cred accesstok ${authCredential.accessToken}');
            log('auth cred provider id ${authCredential.providerId}');
            log('auth cred sign in method ${authCredential.signInMethod}');
          },
          verificationFailed: (FirebaseAuthException authException) {
            log('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
          },
          codeSent: (String verificationId, [int? forceResendingToken]) {
            // first stage after enter otp
            log('force resending token $forceResendingToken');
            log('code sent');
            verificationid = verificationId;
            log(phoneNumber);
            Get.toNamed(
              Routes.OTP_SCREEN,
              arguments: <dynamic>[verificationId, phoneNumber],
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            log('verificationId  $verificationId');
            log('Timwout');
            log('Phone code auto-retrieval timed out. Verification ID: $verificationId');
          },
        )
            .catchError((dynamic e) {
          log('catch err $e');
        });
      } catch (e) {
        log('carch $e');
      }
    } else {
      log('not valid');
    }
  }

  String? phoneNumberValidator(String value) =>
      GetUtils.isLengthEqualTo(value, 10)
          ? null
          : 'Please enter a valid phone number';
}
