import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tour_maker/app/widgets/custom_drop_down.dart';
import 'package:tour_maker/app/widgets/custom_elevated_button.dart';
import 'package:tour_maker/app/widgets/custom_textformFfeld.dart';
import 'package:tour_maker/core/theme/style.dart';

import '../../../../core/tour_maker_icons.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                      child: Column(
                    children: [
                      CustomTextFormField(
                        prefix: Icon(TourMaker.profile_icon, color: fontColor),
                        hintText: 'Username',
                        validator: (value) =>
                            controller.usernameValidator(value),
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 10),
                      CustomDropDownButton(
                        lists: controller.states,
                        onChange: (index, value) =>
                            controller.state.value = value,
                        initialValue: controller.state.value,
                      ),
                      CustomButton().showIconButtonWithGradient(
                          text: 'continue', onPressed: () {})
                    ],
                  )),
                )
              ],
            ),
          ),
        ));
  }
}
