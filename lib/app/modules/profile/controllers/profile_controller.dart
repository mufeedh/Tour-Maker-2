// ignore_for_file: unnecessary_overrides

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/style.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repo/user_repo.dart';
import '../../../services/network_services/dio_client.dart';

class ProfileController extends GetxController with StateMixin {
  // final ImagePicker _picker = ImagePicker();
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;
  Rx<UserModel> userData = UserModel().obs;
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
