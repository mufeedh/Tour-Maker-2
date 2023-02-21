import 'dart:developer';

import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayController extends GetxController {
  Razorpay _razorpay = Razorpay();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

// PaymentData paymentData = PaymentData(
//   amount: 10000, // amount in paise
//   currency: "INR",
//   orderId: "<YOUR_ORDER_ID>",
//   // Other optional parameters
// );
// razorpay.open(paymentData);

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    log('success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure

    log('failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response
    log('ext wallet');
  }
}
