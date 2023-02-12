// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/style.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

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

  onPickedFromGallery() async {
    // await _picker
    //     .pickImage(source: ImageSource.gallery)
    //     .then((XFile? xfile) => xfile != null ? cropImage(xfile.path) : null);
  }

  Future<void> onPickedFromCamera() async {
    // await _picker
    //     .pickImage(source: ImageSource.camera)
    //     .then((XFile? xfile) => xfile != null ? cropImage(xfile.path) : null);
  }
}
