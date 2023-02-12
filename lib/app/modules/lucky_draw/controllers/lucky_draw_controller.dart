// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class LuckyDrawController extends GetxController {
  String tokenText =
      '''Welcome USER!\nGet ready for a chance to win big!\nwe're excited to announce that once we reach 10,000 users, we'll be conducting a lucky draw contest.\nstay tuned for more information on how to participate and the prizes you can win.\nin the meantime, invite your friends and family to join the app and increase your chances of being one of the lucky winners. \n LET'S REACH OUR GOAL TOGETHER!  ''';
  final RxInt count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isFinished = false.obs;
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

  void increment() => count.value++;

  void onFinished() {
    isFinished.value = true;
  }

  void onClickDemoApp() {}

  void onClickPayment() {}
}
