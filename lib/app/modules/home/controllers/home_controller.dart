import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PageController pageViewController = PageController();
  final initialPage = 0;
  var currentIndex = 0.obs;
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

  onTapNavigationBar(int index) {
    pageViewController.animateToPage(index,
        duration: const Duration(microseconds: 500), curve: Curves.ease);
    currentIndex.value = index;
  }

  onPageViewChanged(int value) {
    currentIndex.value = value;
  }
}
