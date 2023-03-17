// ignore_for_file: unnecessary_overrides

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../data/models/razorpay_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repo/razorpay_repo.dart';
import '../../../data/repo/user_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/profile_view.dart';

class ProfileController extends GetxController with StateMixin<ProfileView> {
  late Razorpay razorPay;
  RxBool isloading = false.obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<RazorPayModel> razorPayModel = RazorPayModel().obs;
  String? username;

  int? amount;
  UserRepository userRepo = UserRepository();
  Rx<ImageProvider<Object>> image = Image.asset('assets/Avatar.png').image.obs;

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getData();
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    final ApiResponse<UserModel> res = await userRepo.getUserDetails();

    if (res.status == ApiResponseStatus.completed && res.data != null) {
      userData.value = res.data!;
      username = userData.value.name;
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log('Payment success: ${response.signature}');
    final String? signature = response.signature;
    final String? orderId = razorPayModel.value.packageId;
    final String? paymentId = response.paymentId;

    final ApiResponse<bool> res =
        await RazorPayRepository().verifyPayment(paymentId, signature, orderId);
    try {
      if (res.status == ApiResponseStatus.completed && res.data!) {
        log('Payment verification succeeded.');
        showRegisterBttomSheet(
            userData.value.name.toString(),
            userData.value.state.toString(),
            userData.value.phoneNumber.toString());
      } else {
        log('Payment verification failed: ${res.message}');
      }
    } catch (e) {
      log('Error while handling payment success: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Payment error: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('External wallet: ${response.walletName}');
  }

  Future<void> onClickPayment() async {
    isloading.value = true;
    final RazorPayModel razorPaymodel = RazorPayModel(
      amount: 1000,
      contact: userData.value.phoneNumber,
      currency: 'INR',
      name: userData.value.name,
    );
    final ApiResponse<RazorPayModel> res =
        await RazorPayRepository().createPayment(razorPaymodel);
    try {
      log('adeeb ${res.message}');
      log('adeeb ${res.data}');
      if (res.data != null) {
        razorPayModel.value = res.data!;
        log('adeeb razorpa ${razorPayModel.value.packageId}');
        openRazorPay(razorPayModel.value.packageId.toString(), 1000);
      } else {
        // log(' adeeb raz emp ');
      }
    } catch (e) {
      log('raz catch $e');
    }
    isloading.value = false;
  }

  Future<void> openRazorPay(String orderId, int amount) async {
    final Map<String, Object?> options = <String, Object?>{
      'key': 'rzp_test_yAFypxWUiCD7H7',
      'amount': 10000 * 100, // convert to paise
      'name': userData.value.name,
      'description': 'Test Payment',
      'order_id': orderId,
      'prefill': <String, Object?>{
        // 'email': widget.email,
        'contact': userData.value.phoneNumber,
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

  Future<void> getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        image.value = FileImage(File(pickedFile.path));
        // final File file = File(pickedFile.path);

        log('pickedfile ${pickedFile.path.split('/').last}');
        final ApiResponse<Map<String, dynamic>> res =
            await userRepo.addUserProfilePic(
                pickedFile.path.split('/').last, pickedFile.path);
        if (res.status == ApiResponseStatus.completed) {
          log('completed');
        }
      } else {
        log('No image selected.');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void showRegisterBttomSheet(String name, String state, String phoneNumber) {
    Get.offAllNamed(Routes.USER_REGISTERSCREEN,
        arguments: <String>[name, state, phoneNumber]);
  }
}

RxBool isShowButton = true.obs;
