// ignore_for_file: unnecessary_overrides

import 'dart:developer';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../data/models/razorpay_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repo/user_repo.dart';
import '../../../services/network_services/dio_client.dart';
import '../views/profile_view.dart';

class ProfileController extends GetxController with StateMixin<ProfileView> {
  late Razorpay razorPay;
  RxBool isloading = false.obs;
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<RazorPayModel> razorPayModel = RazorPayModel().obs;
  Rx<XFile>? imgXfile;
  String? username;
  int? amount;
  UserRepository userRepo = UserRepository();
  @override
  void onInit() {
    super.onInit();
    getData();
    // razorPay = Razorpay();
    // razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
    log('adeeb status${res.status}');
    log('adeeb message${res.message}');
    log('adeeb data${res.data}');
    if (res.status == ApiResponseStatus.completed && res.data != null) {
      userData.value = res.data!;
      username = userData.value.name;
      log('user ${userData.value.name}');
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
  }

  // Future<void> getImageFromCamera() async {
  //   imgXfile?.value =
  //       (await ImagePicker().pickImage(source: ImageSource.camera))!;
  // }

  // Future<void> getImage(ImageSource imageSource) async {
  //   final XFile? pickedFile =
  //       await ImagePicker().pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //     selectedImageSize.value =
  //         '${(File(selectedImagePath.value).lengthSync() / 124 / 124).toStringAsFixed(2)} Mb';
  //   } else {
  //     Get.snackbar('err', 'No  Image Selected');
  //   }
  // }

  // void onClickCamera() {}
  // Future<String> cropImage(String fPath) async {
  //   final String? file = await ImageCropper()
  //       .cropImage(
  //     sourcePath: fPath,
  //     aspectRatioPresets: <CropAspectRatioPreset>[
  //       CropAspectRatioPreset.square,
  //     ],
  //     compressQuality: 50,
  //     uiSettings: <PlatformUiSettings>[
  //       AndroidUiSettings(
  //           toolbarColor: englishViolet,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.square,
  //           lockAspectRatio: true,
  //           activeControlsWidgetColor: englishViolet),

  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //       // WebUiSettings(
  //       //   context: context,
  //       // ),
  //     ],
  //   )
  //       .then((CroppedFile? croppedFile) {
  //     return croppedFile?.path;
  //     // filePath.value =
  //   });
  //   return file.toString();
  // }

  // ignore: unused_element
  // Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   log('Payment success: ${response.signature}');
  //   final String? signature = response.signature;
  //   final String? orderId = razorPayModel.value.packageId;
  //   final String? paymentId = response.paymentId;

  //   final ApiResponse<bool> res =
  //       await RazorPayRepository().verifyPayment(paymentId, signature, orderId);
  //   try {
  //     if (res.status == ApiResponseStatus.completed && res.data!) {
  //       log('Payment verification succeeded.');
  //     } else {
  //       log('Payment verification failed: ${res.message}');
  //     }
  //   } catch (e) {
  //     log('Error while handling payment success: $e');
  //   }
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   log('Payment error: ${response.code} - ${response.message}');
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   log('External wallet: ${response.walletName}');
  // }

  // Future<void> onClickPayment() async {
  //   isloading.value = true;
  //   final RazorPayModel razorPaymodel = RazorPayModel(
  //     amount: amount,
  //     contact: userData.value.phoneNumber,
  //     currency: 'INR',
  //     name: userData.value.userName,
  //   );
  //   final ApiResponse<RazorPayModel> res =
  //       await RazorPayRepository().createPayment(razorPaymodel);
  //   try {
  //     // log('adeeb ${res.message}');
  //     // log('adeeb ${res.data}');
  //     if (res.data != null) {
  //       razorPayModel.value = res.data!;
  //       // log('adeeb razorpa ${razorPayModel.value.packageId}');
  //       openRazorPay(razorPayModel.value.packageId.toString(), amount!);
  //     } else {
  //       // log(' adeeb raz emp ');
  //     }
  //   } catch (e) {
  //     log('raz catch $e');
  //   }
  //   isloading.value = false;
  // }

  // void openRazorPay(String orderId, int amount) {
  //   final Map<String, Object?> options = <String, Object?>{
  //     'key': 'rzp_test_P4CbygdUfrhYr3',
  //     'amount': amount * 100, // convert to paise
  //     'name': userData.value.userName,
  //     'description': 'Test Payment',
  //     'order_id': orderId,
  //     'prefill': <String, Object?>{
  //       // 'email': widget.email,
  //       'contact': userData.value.phoneNumber,
  //     },
  //     'external': <String, Object?>{
  //       'wallets': ['paytm'],
  //     },
  //   };

  //   try {
  //     razorPay.open(options);
  //   } catch (e) {
  //     log('Error opening Razorpay checkout: $e');
  //   }
  // }
  // onPickedFromGallery() async {
  //   await _picker
  //       .pickImage(source: ImageSource.gallery)
  //       .then((XFile? xfile) => xfile != null ? cropImage(xfile.path) : null);
  // }

  // onPickedFromCamera() async {
  //   await _picker
  //       .pickImage(source: ImageSource.camera)
  //       .then((XFile? xfile) => xfile != null ? cropImage(xfile.path) : null);
  // }
}
