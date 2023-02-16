import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repo/user_repo.dart';
import '../../../services/network_services/dio_client.dart';

class LoginController extends GetxController with StateMixin {
  GlobalKey<FormState> formKey = GlobalKey();
  UserRepository userRepo = UserRepository();
  late List<String> states = userRepo.getStates();
  @override
  RxString state = ''.obs;
  RxString name = ''.obs;
  RxString phone = ''.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    loadUserCredentials();
    state.value = states[0];
  }

  String? usernameValidator(String? value) =>
      GetUtils.isLengthLessOrEqual(value, 4) ? 'Please enter your name' : null;

  Future<void> onClickContinue(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (state.value == states[0]) {
        Get.snackbar('Select your district', 'please select your country');
      }
      final UserModel user = UserModel(
        userName: name.value,
        phoneNumber: phone.value,
        state: state.value,
      );
      final ApiResponse<Map<String, dynamic>> res =
          await userRepo.signUpTheUser(user);
      if (res.status == ApiResponse.completed) {
        log('completed');
      } else {
        log('sdfgsg');
      }
    }
  }

  void loadUserCredentials() {
    if (Get.arguments != null) {
      phone.value = Get.arguments as String;
    }
  }
}
