import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_textformfield.dart';
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
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                      child: Column(
                    children: <Widget>[
                      CustomTextFormField(
                        prefix: Icon(TourMaker.profile_icon, color: fontColor),
                        hintText: 'Username',
                        validator: (String? value) =>
                            controller.usernameValidator(value),
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: 10),
                      CustomDropDownButton(
                        lists: controller.states,
                        onChange: (int index, String value) =>
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
