// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_elevated_button.dart';

class LuckyDrawController extends GetxController {
  String tokenText =
      '''Welcome USER!\nGet ready for a chance to win big!\nwe're excited to announce that once we reach 10,000 users, we'll be conducting a lucky draw contest.\nstay tuned for more information on how to participate and the prizes you can win.\nin the meantime, invite your friends and family to join the app and increase your chances of being one of the lucky winners. \n LET'S REACH OUR GOAL TOGETHER!  ''';
  final RxInt count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isFinished = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  String typewriterAudio = 'assets/typewriter-1.mp3';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    log('hello');

    playAudio();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
  }

  Future<void> playAudio() async {
    await audioPlayer.play(AssetSource('typewriter-1.mp3'));
  }

  Future<void> onFinished() async {
    isFinished.value = true;
    await audioPlayer.pause();
    showSheet();
  }

  void onClickDemoApp() {
    Get.offAllNamed(Routes.HOME);
  }

  void onClickPayment() {}

  void showSheet() {
    Get.bottomSheet(
      enterBottomSheetDuration: const Duration(milliseconds: 600),
      exitBottomSheetDuration: const Duration(milliseconds: 600),
      isDismissible: true,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 22),
        child: SizedBox(
          height: 42.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomButton().showIconButton(
                    height: 12.h,
                    isLoading: isLoading.value,
                    // width: 100.h,
                    text: '      Pay Rs 424+GST',
                    onPressed: () => onClickPayment(),
                  ),
                  CustomButton().showButtonWithGradient(
                      height: 12.h,
                      isLoading: isLoading.value,
                      // width: 100.h,
                      text: 'See a demo of the App',
                      onPressed: () => onClickDemoApp()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
