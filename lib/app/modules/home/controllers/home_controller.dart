// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PageController pageViewController = PageController();
  final int initialPage = 0;
  RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    log('lOGITWCXH init');
    super.onInit();
  }

  @override
  void onReady() {
    log('lOGITWCXH ready');
    super.onReady();
  }

  @override
  void onClose() {
    log('lOGITWCXH close');
    super.onClose();
  }

  void onTapNavigationBar(int index) {
    pageViewController.animateToPage(index,
        duration: const Duration(microseconds: 500), curve: Curves.ease);
    currentIndex.value = index;
  }

  int onPageViewChanged(int value) {
    return currentIndex.value = value;
  }
}
