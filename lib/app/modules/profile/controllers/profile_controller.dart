// ignore_for_file: unnecessary_overrides

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../core/theme/style.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repo/user_repo.dart';
import '../../../services/network_services/dio_client.dart';

class ProfileController extends GetxController with StateMixin<dynamic> {
  // final ImagePicker _picker = ImagePicker();
  Razorpay razorpay = Razorpay();
  var isloading = false.obs;
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  Rx<UserModel> userData = UserModel().obs;
  Rx<XFile>? imgXfile;
  UserRepository userRepo = UserRepository();
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    final ApiResponse<UserModel> res = await userRepo.getUserDetails();
    if (res.status == ApiResponseStatus.completed) {
      userData.value = res.data!;
      log('user ${userData.value.userName}');
      change(null, status: RxStatus.success());
    } else {}
  }

  Future<void> getImageFromCamera() async {
    imgXfile?.value =
        (await ImagePicker().pickImage(source: ImageSource.camera))!;
  }

  Future<void> getImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          '${(File(selectedImagePath.value).lengthSync() / 124 / 124).toStringAsFixed(2)} Mb';
    } else {
      Get.snackbar('err', 'No  Image Selected');
    }
  }

  void onClickCamera() {}
  Future<String> cropImage(String fPath) async {
    final String? file = await ImageCropper()
        .cropImage(
      sourcePath: fPath,
      aspectRatioPresets: <CropAspectRatioPreset>[
        CropAspectRatioPreset.square,
      ],
      compressQuality: 50,
      uiSettings: <PlatformUiSettings>[
        AndroidUiSettings(
            toolbarColor: englishViolet,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            activeControlsWidgetColor: englishViolet),

        IOSUiSettings(
          title: 'Cropper',
        ),
        // WebUiSettings(
        //   context: context,
        // ),
      ],
    )
        .then((CroppedFile? croppedFile) {
      return croppedFile?.path;
      // filePath.value =
    });
    return file.toString();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    log('success payment');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    log('failed paymment');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response
    log('externnal');
  }

  Map<String, dynamic> options = {
    'key': 'rzp_test_P4CbygdUfrhYr3',
    'amount': 10000, // amount in paise
    'name': 'TourMaker',
    'description': 'Test Payment',
    'prefill': {'contact': '', 'email': 'test@acme.com'},
    'external': {
      'wallets': ['paytm', 'Google Pay']
    }
  };

  onClickPayment() {
    isloading.value = true;
    try {
      log('opened');
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
      log('print $e');
    }
    isloading.value = false;
  }
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
