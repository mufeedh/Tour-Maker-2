import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/terms_and_conditions_controller.dart';

class TermsAndConditionsView extends GetView<TermsAndConditionsController> {
  const TermsAndConditionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset('assets/Accept illustration.png'),
              const SizedBox(height: 30),
              Text('Terms & Conditions', style: heading2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                child: Text(controller.termsAndCond, style: paragraph4),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Obx(() {
                      return Checkbox(
                        value: controller.ischecked.value,
                        onChanged: (bool? value) => controller.onCheck(value!),
                        activeColor: englishViolet,
                      );
                    }),
                    Text(
                        'By clicking here, I state that I have read \nand understood the terms and conditions.',
                        style: paragraph4),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () => controller.isButtonVisisble.value
                    ? SizedBox(
                        width: 280,
                        height: 68,
                        child: CustomButton().showButtonWithGradient(
                          text: "Let's Get Started",
                          onPressed: () => controller.onGetStartedClicked(),
                        ),
                      )
                    : SizedBox(
                        width: 280,
                        height: 68,
                        child: CustomButton().showButton(
                          bgColor: Colors.grey,
                          text: "Let's Get Started",
                          onPressed: () {},
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
