import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/customdatepicker.dart';
import '../controllers/add_passenger_controller.dart';

class AddPassengerView extends GetView<AddPassengerController> {
  const AddPassengerView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(),
        resizeToAvoidBottomInset: true,
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (AddPassengerView? state) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(height: 29),
                  Text(
                    'Enter Passenger Details',
                    style: heading2,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Enter Passenger Details',
                    style: subheading3,
                  ),
                  SizedBox(height: 25.h),
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.group_add,
                            color: Colors.grey.shade400,
                            size: 60,
                          ),
                          const Text(
                            'Add Passengers',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showAddPassengerDialogue(context),
          backgroundColor: englishViolet,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> showAddPassengerDialogue(BuildContext context) {
    return Get.dialog(
      transitionCurve: Curves.easeInCubic,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 700),
      useSafeArea: true,
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(TourMaker.close_circle_1,
                            color: englishViolet),
                      )
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (String? value) =>
                        controller.customerName.value = value.toString(),
                    validator: (String? value) =>
                        controller.nameValidator(value),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(30),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      hintText: 'Name',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          TourMaker.profile_icon,
                          color: fontColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    onChanged: (String? value) =>
                        controller.customerPhone.value = value.toString(),
                    validator: (String? value) =>
                        controller.phoneNumberValidator(value),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(30),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      hintText: 'Phone Number',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          TourMaker.call,
                          color: fontColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomDatePickerField(
                    labelName: 'Date Of Birth',
                    validator: (value) {},
                    onChange: (value) {},
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    maxLines: 10,
                    minLines: 1,
                    onChanged: (String? value) =>
                        controller.customerAddress.value = value.toString(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(30),
                      filled: true,
                      fillColor: const Color(0xFFF6F6F6),
                      hintText: 'Address',
                      prefixIcon: Icon(
                        TourMaker.location_icon,
                        color: fontColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          '      Aadhar Card',
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () {
                            onClickCamera(context);
                            // add your code to capture or select an image here
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(() {
                    return CustomButton().showIconButtonWithGradient(
                      height: 75,
                      width: 100.h,
                      isLoading: controller.isloading.value,
                      text: '      Submit',
                      onPressed: () => controller.onRegisterClicked(),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> onClickCamera(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text('Choose profile pic from :'),
          content: Container(
            padding: const EdgeInsets.all(8),
            height: 140,
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.image, color: englishViolet),
                    title: const Text('Gallery'),
                    onTap: () {
                      controller.getImage(ImageSource.gallery);
                      Get.back();
                    }),
                ListTile(
                    leading:
                        Icon(Icons.camera_alt_rounded, color: englishViolet),
                    title: const Text('Camera'),
                    onTap: () {
                      controller.getImage(ImageSource.camera);
                      Get.back();
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
