// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({super.key});
  @override
  Widget build(BuildContext context) {
    final GetStartedController controller = Get.put(GetStartedController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: controller.obx(
        (state) => Stack(
          children: <Widget>[
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
                'WE MAKE YOUR DREAM TO REALITY',
                style: TextStyle(
                  fontFamily: 'Mesa',
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton().showIconButtonWithGradient(
                    height: 72,
                    width: 100.w,
                    isLoading: controller.isloading.value,
                    text: '     Continue',
                    onPressed: () {
                      onClickContinue(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickContinue(BuildContext context) {
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
            children: <Widget>[
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
                  hintText: 'Phone Number',
                  validator: (String? value) =>
                      // ignore: unnecessary_null_checks
                      controller.phoneNumberValidator(value!),
                  onChanged: (String? value) => controller.phone = value,
                  prefix: Obx(
                    () => controller.selectedCountry?.value == null
                        ? Container()
                        : InkWell(
                            onTap: () => controller.showCountryPicker(),
                            child: Image.asset(
                              controller.selectedCountry?.value.flag as String,
                              width: 100,
                            ),
                          ),
                  ),
                ),
              ),
              CustomButton().showIconButtonWithGradient(
                height: 72,
                width: 100.w,
                text: '     Continue',
                onPressed: () => controller.onVerifyPhoneNumber(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
