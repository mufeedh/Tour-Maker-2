import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tour_maker/app/data/repo/authentication_repo.dart';
import 'package:tour_maker/app/routes/app_pages.dart';

import '../../../../core/theme/style.dart';

class GetStartedController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var verificationId;
  var otp;
  var authStatus = "".obs;
  var isloading = false.obs;
  var phone;
  var selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 2,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  ).obs;
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onCountryCodeClicked(context) {
    showCountryPicker(
      countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          bottomSheetHeight: 500,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          textStyle: subheading1),
      context: context,
      onSelect: (value) => selectedCountry.value = value,
    );
  }

  Future<void> verifyPhoneNumber(BuildContext context) async {
    var phoneNum = '${selectedCountry.value.phoneCode}${phone}';
    print('phone :${phoneNum}');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredential) {
          authStatus.value = "Your account is successfully verified";
        },
        verificationFailed: (FirebaseAuthException authException) {
          authStatus.value = "Authentication failed";
        },
        codeSent: (String verId, [int? forceCodeResent]) {
          verificationId = verId;
          authStatus.value = "OTP has been successfully send";
          Get.toNamed(Routes.OTP_SCREEN, arguments: [phoneNum, verificationId]);
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
          authStatus.value = "TIMEOUT";
        });
  }

  phoneNumberValidator(value) => GetUtils.isLengthLessOrEqual(value, 9)
      ? "Please enter a valid phone number"
      : null;

  onClickContinue(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      print("validated");
      try {
        print('object');
        void sendOTP(String phoneNumber, PhoneCodeSent codeSent,
            PhoneVerificationFailed verificationFailed) {
          if (!phoneNumber.contains('+')) phoneNumber = '+91' + phoneNumber;
          auth.verifyPhoneNumber(
              phoneNumber: phoneNumber,
              timeout: Duration(seconds: 30),
              verificationCompleted: (PhoneAuthCredential cred) {},
              verificationFailed: verificationFailed,
              codeSent: codeSent,
              codeAutoRetrievalTimeout: (_) {});
        }
      } catch (e) {}
    }
  }
}
