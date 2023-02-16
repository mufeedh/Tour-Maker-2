// ignore_for_file: use_named_constants

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    // final double h = MediaQuery.of(context).size.height;
    // final double w = MediaQuery.of(context).size.width;
    // final SplashScreenController controller = Get.put(SplashScreenController());
    final SplashScreenController controller = Get.put(SplashScreenController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx((dynamic state) => Center(
              child: Image.asset(
                'assets/Logo.png',
                width: 60.w,
              ),
            ))
        //  Center(
        //   child: Column(
        //     // mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       AnimatedContainer(
        //         duration:
        //             Duration(milliseconds: controller.d.value ? 900 : 2500),
        //         curve: controller.d.value
        //             ? Curves.fastLinearToSlowEaseIn
        //             : Curves.elasticOut,
        //         height: controller.d.value
        //             ? 0
        //             : controller.a.value
        //                 ? h / 2
        //                 : 20,
        //         width: 20,
        //         // color: Colors.deepPurpleAccent,
        //       ),
        //       AnimatedContainer(
        //         duration: Duration(
        //           seconds: controller.d.value
        //               ? 1
        //               : controller.c.value
        //                   ? 2
        //                   : 0,
        //         ),
        //         curve: Curves.fastLinearToSlowEaseIn,
        //         height: controller.d.value
        //             ? h
        //             : controller.c.value
        //                 ? 80
        //                 : 20,
        //         width: controller.d.value
        //             ? w
        //             : controller.c.value
        //                 ? 200
        //                 : 20,
        //         decoration: BoxDecoration(
        //             color:
        //                 controller.b.value ? englishViolet : Colors.transparent,
        //             // shape: controller.c? BoxShape.rectangle : BoxShape.circle,
        //             borderRadius: controller.d.value
        //                 ? const BorderRadius.only()
        //                 : BorderRadius.circular(30)),
        //         child: Center(
        //           child: controller.e.value
        //               //?Image.asset("assets/tourmakersplash.png")
        //               ? AnimatedContainer(
        //                   duration: const Duration(seconds: 3),
        //                   child: Image.asset('assets/Logo.png'),
        //                 )
        //               : const SizedBox(),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
