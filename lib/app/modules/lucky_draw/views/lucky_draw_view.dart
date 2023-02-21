import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../controllers/lucky_draw_controller.dart';

class LuckyDrawView extends GetView<LuckyDrawController> {
  const LuckyDrawView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  onFinished: () => controller.onFinished(),
                  animatedTexts: <AnimatedText>[
                    TypewriterAnimatedText(
                      controller.tokenText,
                      // curve: Curves.easeInOutCirc,
                      speed: const Duration(microseconds: 80000),
                      textAlign: TextAlign.left,
                      textStyle: const TextStyle(
                          letterSpacing: 3,
                          leadingDistribution: TextLeadingDistribution.even,
                          wordSpacing: 4,
                          fontFamily: 'TypeWriter',
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => controller.isFinished.value
                  ? Column(
                      children: <Widget>[
                        CustomButton().showIconButton(
                          height: 12.h,
                          isLoading: controller.isLoading.value,
                          width: 100.h,
                          text: '           Pay Rs 424+GST ',
                          onPressed: () => controller.onClickPayment(),
                        ),
                        CustomButton().showIconButtonWithGradient(
                            height: 12.h,
                            isLoading: controller.isLoading.value,
                            width: 100.h,
                            text: '   See a demo of the App',
                            onPressed: () => controller.onClickDemoApp()),
                      ],
                    )
                  : const SizedBox()),
              //  Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: CustomButton().showIconButtonWithGradient(
              //     height: 12.h,
              //     width: 100.h,
              //     text: '  Pay Service Charge Now',
              //     onPressed: () => controller.onClickPayment(),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
