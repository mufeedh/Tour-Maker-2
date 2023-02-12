import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/otp_screen_controller.dart';

class OtpScreenView extends GetView<OtpScreenController> {
  const OtpScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    final OtpScreenController controller = Get.put(OtpScreenController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (state) => Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Image.asset("assets/Illustration.png"),
                  Text('Enter 6 Digit Code', style: heading2),
                  const SizedBox(height: 12),
                  Text(
                    'Enter the OTP send to  ${controller.phone} ',
                    style: subheading3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 17),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: PinFieldAutoFill(
                        decoration: BoxLooseDecoration(
                            strokeColorBuilder: FixedColorBuilder(fontColor)),
                        controller: controller.textEditorController,
                        onCodeSubmitted: (String code) {},
                        currentCode: controller.otpCode.value,
                        onCodeChanged: (String? code) {
                          controller.otpCode.value = code!;
                          controller.countDownController.pause();
                        },
                      ),
                    );
                  }),
                  SizedBox(height: 30),
                  Countdown(
                    seconds: 60,
                    interval: const Duration(milliseconds: 1000),
                    build: (BuildContext context, double currentRemainingtime) {
                      if (currentRemainingtime == 0.0) {
                        return GestureDetector(
                          onTap: () {
                            //resend otp
                          },
                          child: Text("Didn't Recieve OTP? Resend OTP ",
                              style: subheading3),
                        );
                      } else {
                        controller.isLoading.value = true;
                        return Text(
                          "Trying to automatically get OTP |${currentRemainingtime.toString().length == 4 ? " ${currentRemainingtime.toString().substring(0, 2)}" : " ${currentRemainingtime.toString().substring(0, 1)}"}",
                        );
                      }
                    },
                  ),
                  // Pinput(
                  //   length: 6,
                  //   defaultPinTheme: PinTheme(
                  //     width: 60,
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(color: Colors.grey),
                  //     ),
                  //     textStyle: const TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   onCompleted: (String value) {
                  //     controller.otpCode.value = value;
                  //   },
                  // ),

                  const SizedBox(height: 20),
                  CustomButton().showButtonWithGradient(
                    text: 'Verify',
                    onPressed: () => controller.signIn(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
