// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../core/theme/style.dart';
import '../../../../main.dart';
import '../../../data/models/checkout_model.dart';
import '../../../data/models/razorpay_model.dart';
import '../../../data/models/travellers_model.dart';
import '../../../data/repo/passenger_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/network_services/dio_client.dart';
import '../../../widgets/custom_dialogue.dart';
import '../views/add_passenger_view.dart';

class AddPassengerController extends GetxController
    with StateMixin<AddPassengerView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int? orderID;
  late Razorpay razorPay;
  final ImagePicker picker = ImagePicker();
  final TextEditingController controller = TextEditingController();
  final DateTime selectedDate = DateTime.now();
  RxBool isloading = false.obs;
  Rx<OrderPaymentModel> orderPaymentModel = OrderPaymentModel().obs;
  int? totalTravellers;
  RxString image = ''.obs;
  RxList<TravellersModel> travellers = <TravellersModel>[].obs;
  Rx<String> customerAddress = ''.obs;
  Rx<bool> isLoadingIc = false.obs;
  Rx<String> customerName = ''.obs;
  Rx<String> customerPhone = ''.obs;
  Rx<String> customerAdhaar = ''.obs;
  Rx<String> customerDOB = ''.obs;
  @override
  void onInit() {
    super.onInit();
    razorPay = Razorpay();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    loadData();
  }

  String? dobValidator(String? value) => DateTime.tryParse(value ?? '') != null
      ? null
      : 'Please enter a valid DOB';
  String? nameValidator(String? value) => GetUtils.isLengthLessOrEqual(value, 3)
      ? 'Please enter a valid name'
      : null;

  String? phoneNumberValidator(String? value) =>
      GetUtils.isLengthLessOrEqual(value, 9)
          ? 'Please enter a valid phone number'
          : null;

  String? addressValidator(String? value) =>
      GetUtils.isLengthGreaterOrEqual(value, 10)
          ? null
          : 'please enter a valid address';
  void loadData() {
    if (Get.arguments != null) {
      change(null, status: RxStatus.loading());
      orderID = Get.arguments[0] as int;
      totalTravellers = Get.arguments[1] as int;
      change(null, status: RxStatus.success());
    }
  }

  Future<void> onRegisterClicked() async {
    if (formKey.currentState!.validate()) {
      if (image.value != '') {
        isloading.value = true;
        final ApiResponse<bool> res = await PassengerRepository().addpassenger(
            customerName.value,
            customerPhone.value,
            orderID.toString(),
            customerDOB.value,
            customerAddress.value,
            image.value);
        if (res.status == ApiResponseStatus.completed) {
          Get.back();
          image.value = '';
          await getTravellers(orderID);
        } else {
          log('message');
        }
        isloading.value = false;
      } else {
        Get.snackbar('Add your ID proof', 'Add any ID proof',
            backgroundColor: englishViolet, colorText: Colors.white);
      }
    }
    isloading.value = false;
    log(customerDOB.value);
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
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = pickedFile.path;
      log('pickedfile ${pickedFile.path.split('/').last}');
    }
  }

  Future<void> getTravellers(int? orderID) async {
    final ApiResponse<List<TravellersModel>> res =
        await PassengerRepository().getAllPassengersByOrderId(orderID!);
    if (res.data != null) {
      travellers.value = res.data!;
    } else {}
  }

  void gotoCheckoutPage() {
    isLoadingIc.value = true;
    CustomDialog().showCustomDialog('Are your Ready \nto checkout',
        "Please double check \n the data's you entered\n before checkout",
        cancelText: 'Go back', onCancel: () {
      Get.back();
      isLoadingIc.value = false;
    }, onConfirm: () {
      Get.back();
      Get.toNamed(Routes.CHECKOUT_SCREEN)!.whenComplete(() => loadData());
      isLoadingIc.value = false;
    });
    isLoadingIc.value = false;
  }
}
