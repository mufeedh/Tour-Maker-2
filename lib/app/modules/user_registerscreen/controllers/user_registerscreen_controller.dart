import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../data/repo/user_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/user_registerscreen_view.dart';

class UserRegisterscreenController extends GetxController
    with StateMixin<UserRegisterscreenView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  Rx<Gender> selectedGender = Gender.male.obs;
  Rx<CategoryType> selectedCategoryType = CategoryType.Freelance.obs;
  RxBool isloading = false.obs;
  Rx<bool> isFindingAddressOfUser = false.obs;
  Rx<String> userAddress = ''.obs;
  Rx<String> userCountry = ''.obs;
  Rx<String> userState = ''.obs;
  Rx<String> userCity = ''.obs;
  Rx<String> incomingname = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> incomingPhone = ''.obs;
  Rx<String> gender = ''.obs;
  Rx<String> incomingStateValue = ''.obs;
  Rx<String> enterpriseName = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  String? nameValidator(String? value) => GetUtils.isLengthLessOrEqual(value, 3)
      ? 'Please enter a valid name'
      : null;

  String? emailValidator(String? value) =>
      GetUtils.isEmail(value!) ? null : 'Please enter a valid email';

  String? phoneNumberValidator(String? value) =>
      GetUtils.isLengthLessOrEqual(value, 9)
          ? 'Please enter a valid phone number'
          : null;

  String? addressValidator(String? value) => GetUtils.isLengthEqualTo(value, 10)
      ? null
      : 'please enter a valid address';

  Future<void> onRegisterClicked() async {
    if (formKey.currentState!.validate()) {
      isloading.value = true;
      // final UserModel um = UserModel(
      //   category: selectedCategoryType.value
      //       .toString()
      //       .split('.')
      //       .last
      //       .split('_')
      //       .join(' '),
      //   district: userCity.value,
      //   email: email.value,
      //   gender: selectedGender.value
      //       .toString()
      //       .split('.')
      //       .last
      //       .split('_')
      //       .join(' '),
      //   name: incomingname.value,
      //   state: userState.value,
      //   phoneNumber: incomingPhone.value,
      //   address: userAddress.value,
      //   enterpriseName: enterpriseName.value,
      //   tAndCStatus: 'true',
      // );

      final String categoryOFuser = selectedCategoryType.value
          .toString()
          .split('.')
          .last
          .split('_')
          .join(' ');
      final String districtOFuser = userCity.value;
      final String emailOFuser = email.value;
      final String genderOFuser =
          selectedGender.value.toString().split('.').last.split('_').join(' ');
      final String nameOFuser = incomingname.value;
      final String stateOFuser = userState.value;
      final String phoneNumberOfuser = incomingPhone.value;
      final String addressOFuser = userAddress.value;
      final String enterpriseNameOFuser = enterpriseName.value;
      const String tAndCStatusOfUser = 'true';

      await updateUser(
          categoryOFuser,
          districtOFuser,
          emailOFuser,
          genderOFuser,
          nameOFuser,
          stateOFuser,
          phoneNumberOfuser,
          addressOFuser,
          enterpriseNameOFuser,
          tAndCStatusOfUser);
    }
  }

  void loadData() {
    if (Get.arguments != null) {
      change(null, status: RxStatus.loading());
      incomingname.value = Get.arguments[0] as String;
      incomingStateValue.value = Get.arguments[1] as String;
      incomingPhone.value = Get.arguments[2] as String;
      change(null, status: RxStatus.success());
    }
  }

  Future<void> updateUser(
      String categoryOFuser,
      String districtOFuser,
      String emailOFuser,
      String genderOFuser,
      String nameOFuser,
      String stateOFuser,
      String phoneNumberOfuser,
      String addressOFuser,
      String enterpriseNameOFuser,
      String tAndCStatusOfUser) async {
    final ApiResponse<Map<String, dynamic>> res = await UserRepository()
        .updateUser(
            categoryOFuser,
            districtOFuser,
            emailOFuser,
            genderOFuser,
            nameOFuser,
            stateOFuser,
            phoneNumberOfuser,
            addressOFuser,
            enterpriseNameOFuser,
            tAndCStatusOfUser);
    if (res.status == ApiResponseStatus.completed) {
      log('Adeeb updated');
      isloading.value = false;
      Get.offAllNamed(Routes.SPLASH_SCREEN);
    } else {
      log('Adeeb not updated');
    }
  }

  Future<void> getAddressofUser() async {
    log('clicked');
    isFindingAddressOfUser.value = true;
    final Position position = await getGeoLocationPosition();
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks.toString());
    final Placemark place = placemarks[0];
    userAddress.value =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    userState.value = place.administrativeArea.toString();
    userCountry.value = place.country.toString();
    userCity.value = place.locality.toString();
    isFindingAddressOfUser.value = false;
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future<Position>.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future<Position>.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future<Position>.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}

enum Gender {
  male,
  female,
  other;
}

enum CategoryType {
  Freelance,
  Shop,
  Travel_Agency,
  Contact_Carriage,
  E_Service_Centre,
}
