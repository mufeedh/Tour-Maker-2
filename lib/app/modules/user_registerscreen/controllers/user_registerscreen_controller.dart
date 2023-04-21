import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../data/models/network_models/user_model.dart';
import '../../../data/repo/network_repo/user_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/user_registerscreen_view.dart';

class UserRegisterscreenController extends GetxController
    with StateMixin<UserRegisterscreenView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<UserModel> user = UserModel().obs;
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
  Rx<Gender> selectedGender = Gender.Male.obs;
  Rx<CategoryType> selectedCategoryType = CategoryType.Standard_User.obs;
  RxBool isloading = false.obs;
  Rx<bool> isFindingAddressOfUser = false.obs;
  Rx<String> userAddress = ''.obs;
  Rx<String> userCountry = ''.obs;
  Rx<String> userState = ''.obs;
  Rx<String> userCity = ''.obs;
  Rx<String> userName = ''.obs;
  Rx<String> userEmail = ''.obs;
  Rx<String> userPhone = ''.obs;
  Rx<String> usereEnterpriseName = ''.obs;
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

  String? addressValidator(String? value) =>
      GetUtils.isLengthGreaterOrEqual(value, 10)
          ? null
          : 'please enter a valid address';

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    user.value = await getCurrentUserDetails();
    userEmail.value = user.value.email.toString();
    usereEnterpriseName.value = user.value.enterpriseName.toString();
    log('Gender value: ${user.value.gender}');
    selectedGender.value = user.value.gender != null
        ? Gender.values.firstWhere(
            (Gender gender) =>
                gender.toString().split('.').last.toLowerCase() ==
                user.value.gender?.toLowerCase(),
            orElse: () => Gender.Male)
        : Gender.Male;
    log('user category: ${user.value.category}');
    log('CategoryType values: ${CategoryType.values}');
    selectedCategoryType.value =
        categoryTypeMap[user.value.category] ?? CategoryType.Standard_User;
    log('CategoryType values: ${categoryTypeMap[user.value.category]}');

    userPhone.value = user.value.phoneNumber.toString();
    userName.value = user.value.name.toString();
    userAddress.value = user.value.address.toString();
    userCity.value = user.value.district.toString();
    userCountry.value = user.value.country.toString();
    userState.value = user.value.state.toString();
    change(null, status: RxStatus.success());
  }

  Future<UserModel> getCurrentUserDetails() async {
    final ApiResponse<UserModel> response =
        await UserRepository().getUserDetails();
    if (response.data != null) {
      return response.data!;
    }
    return response.data!;
  }

  Future<void> updateUser({
    String? categoryOFuser,
    String? districtOFuser,
    String? emailOFuser,
    String? genderOFuser,
    String? nameOFuser,
    String? stateOFuser,
    String? phoneNumberOfuser,
    String? addressOFuser,
    String? enterpriseNameOFuser,
    String? countryOFuser,
  }) async {
    final ApiResponse<Map<String, dynamic>> res =
        await UserRepository().updateUser(
      categoryOFuser: categoryOFuser,
      districtOFuser: districtOFuser,
      emailOFuser: emailOFuser,
      genderOFuser: genderOFuser,
      nameOFuser: nameOFuser,
      countryOFuser: countryOFuser,
      stateOFuser: stateOFuser,
      phoneNumberOfuser: phoneNumberOfuser,
      addressOFuser: addressOFuser,
      enterpriseNameOFuser: enterpriseNameOFuser,
    );
    if (res.status == ApiResponseStatus.completed) {
      log('Adeeb updated');
      currentUserCategory = categoryOFuser;
      log('Adeeb update usr category $categoryOFuser');
      currentUserAddress = addressOFuser;
      isloading.value = false;
      Get.back();
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

  Future<void> onRegisterClicked() async {
    if (formKey.currentState!.validate()) {
      isloading.value = true;
      final String categoryOFuser = selectedCategoryType.value
          .toString()
          .split('.')
          .last
          .split('_')
          .join(' ');
      final String districtOFuser = userCity.value;
      final String emailOFuser = userEmail.value;
      final String genderOFuser =
          selectedGender.value.toString().split('.').last.split('_').join(' ');
      final String nameOFuser = userName.value;
      final String stateOFuser = userState.value;
      final String phoneNumberOfuser = userPhone.value;
      final String addressOFuser = userAddress.value;
      final String enterpriseNameOFuser = usereEnterpriseName.value;
      final String countryOFuser = userCountry.value;

      await updateUser(
        categoryOFuser: categoryOFuser,
        countryOFuser: countryOFuser,
        districtOFuser: districtOFuser,
        emailOFuser: emailOFuser,
        genderOFuser: genderOFuser,
        nameOFuser: nameOFuser,
        stateOFuser: stateOFuser,
        phoneNumberOfuser: phoneNumberOfuser,
        addressOFuser: addressOFuser,
        enterpriseNameOFuser: enterpriseNameOFuser,
      );
    }
  }
}

enum Gender {
  Male,
  Female,
  Other,
}

enum CategoryType {
  Freelancer,
  Shop,
  Travel_Agency,
  Contact_Carriage,
  E_Service_Centre,
  Standard_User,
}

final Map<String, CategoryType> categoryTypeMap = <String, CategoryType>{
  'Freelancer': CategoryType.Freelancer,
  'Shop': CategoryType.Shop,
  'Travel_Agency': CategoryType.Travel_Agency,
  'Contact_Carriage': CategoryType.Contact_Carriage,
  'E_Service_Centre': CategoryType.E_Service_Centre,
  'Standard_User': CategoryType.Standard_User,
};
