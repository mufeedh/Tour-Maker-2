import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tour_maker/app/widgets/custom_dialogue.dart';
import 'package:tour_maker/core/theme/style.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final count = 0.obs;
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

  onClickCamera() {}
  cropImage(String fPath) async {
    await ImageCropper()
        .cropImage(
      sourcePath: fPath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 50,
      uiSettings: [
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
        .then((croppedFile) {
      return croppedFile?.path;
      // filePath.value =
    });
  }

  onPickedFromGallery() async {
    await _picker.pickImage(source: ImageSource.gallery).then(
        (xfile) => xfile != null ? cropImage(xfile.path.toString()) : null);
  }

  onPickedFromCamera() async {
    await _picker.pickImage(source: ImageSource.camera).then(
        (xfile) => xfile != null ? cropImage(xfile.path.toString()) : null);
  }
}
