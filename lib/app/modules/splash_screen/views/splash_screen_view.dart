import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    var controller = Get.put(SplashScreenController());
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration:
                    Duration(milliseconds: controller.d.value ? 900 : 2500),
                curve: controller.d.value
                    ? Curves.fastLinearToSlowEaseIn
                    : Curves.elasticOut,
                height: controller.d.value
                    ? 0
                    : controller.a.value
                        ? h / 2
                        : 20,
                width: 20,
                // color: Colors.deepPurpleAccent,
              ),
              AnimatedContainer(
                duration: Duration(
                  seconds: controller.d.value
                      ? 1
                      : controller.c.value
                          ? 2
                          : 0,
                ),
                curve: Curves.fastLinearToSlowEaseIn,
                height: controller.d.value
                    ? h
                    : controller.c.value
                        ? 80
                        : 20,
                width: controller.d.value
                    ? w
                    : controller.c.value
                        ? 200
                        : 20,
                decoration: BoxDecoration(
                    color:
                        controller.b.value ? englishViolet : Colors.transparent,
                    // shape: controller.c? BoxShape.rectangle : BoxShape.circle,
                    borderRadius: controller.d.value
                        ? const BorderRadius.only()
                        : BorderRadius.circular(30)),
                child: Center(
                  child: controller.e.value
                      //?Image.asset("assets/tourmakersplash.png")
                      ? AnimatedContainer(
                          duration: Duration(seconds: 3),
                          child: Image.asset("assets/Logo.png"),
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
