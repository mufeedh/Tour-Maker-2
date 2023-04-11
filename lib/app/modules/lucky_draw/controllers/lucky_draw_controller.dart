// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../main.dart';

import '../../../data/models/network_models/razorpay_model.dart';
import '../../../data/repo/network_repo/razorpay_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';

class LuckyDrawController extends GetxController {
  dynamic userName;
  late Razorpay razorPay;
  Rx<RazorPayModel> razorPayModel = RazorPayModel().obs;

  String tokenText =
      '''Welcome $currentUserName!\nGet ready for a chance to win big!\nwe're excited to announce that once we reach 10,000 users, we'll be conducting a lucky draw contest.\nstay tuned for more information on how to participate and the prizes you can win.\nin the meantime, invite your friends and family to join the app and increase your chances of being one of the lucky winners. \n LET'S REACH OUR GOAL TOGETHER!  ''';
  final RxInt count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isFinished = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  String typewriterAudio = 'assets/typewriter-1.mp3';

  @override
  void onInit() {
    super.onInit();
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
  }

  void onClickDemoApp() {
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> onClickPayment() async {
    final RazorPayModel razorPaymodel = RazorPayModel(
      amount: 1000,
      contact: currentUserPhoneNumber,
      currency: 'INR',
      name: currentUserName,
    );
    final ApiResponse<RazorPayModel> res =
        await RazorPayRepository().createPayment(razorPaymodel);
    try {
      if (res.data != null) {
        razorPayModel.value = res.data!;
        openRazorPay(razorPayModel.value.packageId.toString(), 1000);
      } else {
        // log(' adeeb raz emp ');
      }
    } catch (e) {
      // log('raz catch $e');
    }
  }

  Future<void> openRazorPay(String orderId, int amount) async {
    final Map<String, Object?> options = <String, Object?>{
      'key': 'rzp_test_yAFypxWUiCD7H7',
      'amount': 10000 * 100, // convert to paise
      'name': currentUserName,
      'description': 'Test Payment',
      'order_id': orderId,
      'prefill': <String, Object?>{
        'contact': currentUserPhoneNumber,
      },
      'external': <String, Object?>{
        'wallets': <String>['paytm'],
      },
    };

    try {
      razorPay.open(options);
    } catch (e) {
      log('Error opening Razorpay checkout: $e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log('Payment success: ${response.signature}');
    final String? signature = response.signature;
    final String? orderId = razorPayModel.value.packageId;
    final String? paymentId = response.paymentId;

    final ApiResponse<bool> res = await RazorPayRepository()
        .verifyOrderPayment(paymentId, signature, orderId);
    try {
      if (res.status == ApiResponseStatus.completed && res.data!) {
        // log('Payment verification succeeded.');
        showRegisterBttomSheet(currentUserName.toString(),
            currentUserState.toString(), currentUserPhoneNumber.toString());
      } else {
        // log('Payment verification failed: ${res.message}');
      }
    } catch (e) {
      // log('Error while handling payment success: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // log('Payment error: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // log('External wallet: ${response.walletName}');
  }
  void showRegisterBttomSheet(String name, String state, String phoneNumber) {
    Get.offAllNamed(Routes.USER_REGISTERSCREEN,
        arguments: <String>[name, state, phoneNumber]);
  }
}
