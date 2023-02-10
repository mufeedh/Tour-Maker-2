// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_maker/app/widgets/custom_textformFfeld.dart';
import '../../../../core/theme/style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GetStartedController());
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Image.asset(
              'assets/Background.png',
              fit: BoxFit.cover,
              width: 100.w,
              height: 100.h,
            ),
            Positioned(
              top: 14.h,
              left: 10.w,
              child: SvgPicture.asset(
                'assets/tourmaker.svg',
              ),
            ),
            Positioned(
              top: 50.h,
              left: 10.w,
              child: Text(
                "LET'S \nGET\nSTARTED",
                style: TextStyle(
                  fontFamily: 'Mesa',
                  fontWeight: FontWeight.w800,
                  fontSize: 38,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 67.h,
              left: 10.w,
              child: Text(
                "WE MAKE YOUR DREAM TO REALITY",
                style: TextStyle(
                  fontFamily: 'Mesa',
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 5.h, right: 5.h, bottom: 25),
            //   child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: RoundedLoadingButton(
            //         color: Color.fromARGB(255, 97, 45, 109),
            //         height: 72,
            //         controller: controller.btnController,
            //         onPressed: () {
            //           controller.btnController.start();
            //           onClickContinue(context);
            //           controller.btnController.reset();
            //         },
            //         width: 100.w,
            //         animateOnTap: true,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text('      Continue', style: buttonwithWhiteTextStyle),
            //             Container(
            //               margin: EdgeInsets.all(10),
            //               height: 100.h,
            //               width: 14.w,
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color: Colors.white24,
            //               ),
            //               child: Icon(
            //                 Icons.keyboard_arrow_right_outlined,
            //                 size: 25,
            //                 color: Colors.white,
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() => Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton().showIconButtonWithGradient(
                        height: 72,
                        width: 100.w,
                        isLoading: controller.isloading.value,
                        text: '     Continue',
                        onPressed: () {
                          controller.isloading.value = true;
                          onClickContinue(context);
                          controller.isloading.value = false;
                        }),
                  )),
            ),
          ],
        ));
  }

  onClickContinue(BuildContext context) {
    Get.bottomSheet(
      enterBottomSheetDuration: const Duration(milliseconds: 600),
      exitBottomSheetDuration: const Duration(milliseconds: 600),
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      Padding(
        padding: EdgeInsets.all(22),
        child: SizedBox(
          height: 42.h,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Welcome To TourMaker',
                style: heading2,
              ),
              Text(
                'Insert your phone number to continue',
                style: paragraph2,
              ),
              Form(
                key: controller.formKey,
                child: CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  contentPadding: const EdgeInsets.all(8),
                  hintText: "Phone Number",
                  prefix: Obx(() {
                    return InkWell(
                      onTap: () => controller.onCountryCodeClicked(context),
                      child: Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.only(right: 10),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: Transform.scale(
                          scale: 1.7,
                          alignment: Alignment.center,
                          child: Text(
                            controller.selectedCountry.value.flagEmoji,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 38.0),
                          ),
                        ),
                      ),
                    );
                  }),
                  validator: (value) => controller.phoneNumberValidator(value),
                  onChanged: (value) => controller.phone = value,
                ),
              ),
              CustomButton().showIconButtonWithGradient(
                height: 72,
                width: 100.w,
                text: '     Continue',
                onPressed: () => controller.verifyPhoneNumber(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
