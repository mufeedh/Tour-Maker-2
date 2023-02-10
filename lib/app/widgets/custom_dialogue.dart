import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/style.dart';
import 'custom_elevated_button.dart';

class CustomDialog {
  showCustomDialog(
    String title,
    String contentText, {
    String cancelText = "Cancel",
    String confirmText = "Confirm",
    Function()? onCancel,
    Function()? onConfirm,
    bool barrierDismissible = true,
  }) {
    return Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(37)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: subheading2.copyWith(),
                    child: Text(title),
                  ),
                  const SizedBox(height: 16),
                  DefaultTextStyle(
                    style: subheading2.copyWith(),
                    child: Text(contentText),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onCancel != null)
                        CustomButton().showButton(text: "", onPressed: () {}),
                      // CustomElevatedButton(
                      //   text: cancelText,
                      //   onPressed: onCancel,
                      //   bgColor: englishlinearViolet,
                      //   textColor: fontColor,
                      // ),
                      if (onConfirm != null) const SizedBox(width: 20),
                      CustomButton()
                          .showButtonWithGradient(text: "", onPressed: () {})
                      // Container(
                      //   width: 240,
                      //   height: 68,
                      //   child: CustomElevatedButton(
                      //     text: "Continue",
                      //     onPressed: onConfirm ?? () => Get.back(),
                      //     bgColor: englishlinearViolet,
                      //   ),
                      // )
                    ],
                  ),
                ],
              )),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}
