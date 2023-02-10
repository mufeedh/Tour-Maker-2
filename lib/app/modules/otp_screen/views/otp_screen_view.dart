import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../controllers/otp_screen_controller.dart';

class OtpScreenView extends GetView<OtpScreenController> {
  const OtpScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OtpScreenController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (state) => Padding(
            padding: const EdgeInsets.all(28.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Image.asset("assets/Illustration.png"),
                  Text("Enter 6 Digit Code", style: heading2),
                  const SizedBox(height: 12),
                  Text(
                    "Enter the OTP send to  ${controller.phone} ",
                    style: subheading3,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 17),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      controller.otpCode.value = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  Text("Didn't Recieve OTP? Resend OTP in 0:58",
                      style: subheading3),
                  const SizedBox(height: 15),

                  CustomButton().showButtonWithGradient(
                    text: "Verify",
                    onPressed: () => controller.signIn(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
