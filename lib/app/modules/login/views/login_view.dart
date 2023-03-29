import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: fontColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ALMOST \nTHERE',
                  style: TextStyle(
                    fontFamily: 'Mesa',
                    color: englishViolet,
                    fontSize: 44,
                  ),
                ),
                Text(
                  'Enter your credentials here',
                  style: subheading2,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.name,
                            validator: (String? value) =>
                                controller.usernameValidator(value),
                            onChanged: (String? value) =>
                                controller.name.value = value.toString(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(30),
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              hintText: 'NAME',
                              prefixIcon: Icon(TourMaker.profile_icon,
                                  color: fontColor),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomDropDownButton(
                            lists: controller.states,
                            onChange: (int index, String value) =>
                                controller.state.value = value,
                            initialValue: controller.state.value,
                          ),
                          Obx(() => CustomButton().showIconButtonWithGradient(
                                height: 72,
                                isLoading: controller.isLoading.value,
                                width: 100.w,
                                text: '     Continue',
                                onPressed: () =>
                                    controller.onClickContinue(context),
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
