// ignore_for_file: unnecessary_overrides, avoid_print, unused_element, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_calling_code_picker/picker.dart';
import '../../home/views/home_view.dart';
import '../../otp_screen/views/otp_screen_view.dart';

class GetStartedController extends GetxController with StateMixin {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  int? verificationId;
  int? otp;
  RxBool isButtonVisible = true.obs;
  RxBool isloading = false.obs;
  RxString authStatus = ''.obs;
  String? phone;

  BuildContext? context;
  Rx<Country>? selectedCountry;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
    initCountry();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initCountry() async {
    // final Country country = await getDefaultCountry(context);

    // selectedCountry?.value = country;
  }

  Future<void> showCountryPicker() async {
    final Country? country = await showCountryPickerSheet(context!);
    if (country != null) {
      selectedCountry?.value = country;
    }
  }

  void onCountryCodeClicked(BuildContext context) {}

  Future<void> onVerifyPhoneNumber(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      print('valid');
      isloading.value = true;
      // Get.back();
      final FirebaseAuth auth = FirebaseAuth.instance;
      auth
          .verifyPhoneNumber(
        phoneNumber: '+91$phone',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          isloading.value = true;

          auth.signInWithCredential(authCredential).then(
              (UserCredential result) => Get.to(const HomeView(),
                  arguments: result.user,
                  transition: Transition.leftToRightWithFade));
          isloading.value = false;
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message);
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          Get.to(const OtpScreenView(),
              arguments: [verificationId, forceResendingToken, phone],
              transition: Transition.leftToRightWithFade);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print('verificationId  $verificationId');
          print('Timwout');
        },
      )
          .catchError((e) {
        print(e);
      });
      isloading.value = false;
    } else {
      print('not valid');
    }
  }

  String? phoneNumberValidator(String value) =>
      GetUtils.isLengthLessOrEqual(value, 9)
          ? 'Please enter a valid phone number'
          : null;
}
