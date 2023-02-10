import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../controllers/lucky_draw_controller.dart';

class LuckyDrawView extends GetView<LuckyDrawController> {
  const LuckyDrawView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: AnimatedTextKit(
                  repeatForever: false,
                  isRepeatingAnimation: false,
                  onFinished: () => controller.onFinished(),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      controller.tokenText.toString(),
                      // curve: Curves.easeInOutCirc,
                      speed: Duration(microseconds: 80000),
                      textAlign: TextAlign.left,
                      textStyle: TextStyle(
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
              SizedBox(height: 30),
              Obx(() => controller.isFinished.value
                  ? Column(
                      children: [
                        CustomButton().showIconButton(
                          height: 72,
                          isLoading: controller.isLoading.value,
                          width: 100.w,
                          text: '                    Pay Rs 424+GST ',
                          onPressed: () => controller.onClickPayment(),
                        ),
                        CustomButton().showIconButtonWithGradient(
                            height: 72,
                            isLoading: controller.isLoading.value,
                            width: 100.w,
                            text: '     See a demo of the App',
                            onPressed: () => controller.onClickDemoApp()),
                      ],
                    )
                  : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
