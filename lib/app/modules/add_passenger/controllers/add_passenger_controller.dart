// ignore_for_file: unnecessary_overrides

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../main.dart';
import '../../../data/models/razorpay_model.dart';
import '../../../data/repo/passenger_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/add_passenger_view.dart';

class AddPassengerController extends GetxController
    with StateMixin<AddPassengerView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? orderID;
  late Razorpay razorPay;
  Rx<OrderPaymentModel> orderPaymentModel = OrderPaymentModel().obs;
  final ImagePicker picker = ImagePicker();
  Rx<ImageProvider<Object>>? image;
  final TextEditingController controller = TextEditingController();
  final DateTime selectedDate = DateTime.now();
  RxBool isloading = false.obs;
  Rx<String> customerAddress = ''.obs;
  Rx<String> customerName = ''.obs;
  Rx<String> customerPhone = ''.obs;
  Rx<String> customerAdhaar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    loadData();
  }

  String? nameValidator(String? value) => GetUtils.isLengthLessOrEqual(value, 3)
      ? 'Please enter a valid name'
      : null;

  String? phoneNumberValidator(String? value) =>
      GetUtils.isLengthLessOrEqual(value, 9)
          ? 'Please enter a valid phone number'
          : null;

  String? addressValidator(String? value) => GetUtils.isLengthEqualTo(value, 10)
      ? null
      : 'please enter a valid address';
  void loadData() {
    if (Get.arguments != null) {
      change(null, status: RxStatus.loading());
      orderID = Get.arguments as int;
      change(null, status: RxStatus.success());
    }
  }

  Future<void> onRegisterClicked() async {
    if (formKey.currentState!.validate()) {
      isloading.value = true;
      // var res = await PassengerRepository().
    }

    // Future<void> updateUser() async {
    //   orderPaymentModel.value = await createPayment();
    //   //open razorpay
    //   openRazorPay(orderPaymentModel.value.id.toString());
    // }
  }

  void openRazorPay(String paymentID) {
    final Map<String, Object?> options = <String, Object?>{
      'key': 'rzp_test_yAFypxWUiCD7H7',
      'name': 'TourMaker App',
      'description': 'Pay for your Package Order',
      'order_id': paymentID,
      'external': <String, Object?>{
        'wallets': <String>['paytm'],
      },
    };
    log('adeeb anvar $options');

    try {
      razorPay.open(options);
      log('adeeb anvar raz op');
    } catch (e) {
      log('Error opening Razorpay checkout: $e');
    }
  }

  Future<OrderPaymentModel> createPayment() async {
    final OrderPaymentModel omp = OrderPaymentModel(
      orderId: orderID,
      contact: currentUserPhoneNumber,
      currency: 'INR',
    );

    try {
      final ApiResponse<OrderPaymentModel> res =
          await PassengerRepository().createPayment(omp);
      if (res.data != null) {
        orderPaymentModel.value = res.data!;
      } else {
        // log(' adeeb raz emp ');
      }
    } catch (e) {
      log('raz catch $e');
    }
    return orderPaymentModel.value;
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final ApiResponse<bool> res = await PassengerRepository().verifyPayment(
        response.paymentId, response.signature, orderPaymentModel.value.id);
    try {
      if (res.status == ApiResponseStatus.completed) {
      } else {
        log('Payment verification failed: ${res.data}');
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

  Future<void> getImage(ImageSource source) async {
    // try {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image?.value = FileImage(File(pickedFile.path));
      // final File file = File(pickedFile.path);

      log('pickedfile ${pickedFile.path.split('/').last}');
      //   final ApiResponse<Map<String, dynamic>> res =
      //       await User.addUserProfilePic(
      //           pickedFile.path.split('/').last, pickedFile.path);
      //   if (res.status == ApiResponseStatus.completed) {
      //     log('completed');
      //   }
      // } else {
      //   log('No image selected.');
      // }
      // } catch (e) {
      //   log('Error: $e');
      // }
    }
  }
}
