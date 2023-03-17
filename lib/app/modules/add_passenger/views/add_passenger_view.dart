import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/custom_textformfield.dart';
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Form(
                  //     key: controller.formKey,
                  //     child: Column(
                  //       children: <Widget>[
                  //         CustomTextFormField(
                  //           keyboardType: TextInputType.name,
                  //           contentPadding: const EdgeInsets.all(8),
                  //           prefix:
                  //               Icon(TourMaker.profile_icon, color: fontColor),
                  //           hintText: 'Name',
                  //           validator: (String? value) =>
                  //               controller.nameValidator(value),
                  //           onChanged: (String value) =>
                  //               controller.customerName.value = value,
                  //           // initialValue: controller.incomingname.value,
                  //         ),
                  //         const SizedBox(height: 15),
                  //         CustomTextFormField(
                  //             keyboardType: TextInputType.phone,
                  //             contentPadding: const EdgeInsets.all(8),
                  //             hintText: 'Phone Number',
                  //             validator: (String? value) =>
                  //                 controller.phoneNumberValidator(value!),
                  //             onChanged: (String? value) => controller
                  //                 .customerPhone.value = value.toString(),
                  //             // initialValue: controller.incomingPhone.value,
                  //             prefix: Icon(TourMaker.call, color: fontColor)),
                  //         const SizedBox(height: 15),
                  //         TextFormField(
                  //           maxLines: 10,
                  //           minLines: 1,
                  //           // validator: (String? value) =>
                  //           //     controller.addressValidator(value),
                  //           onChanged: (String? value) => controller
                  //               .customerAddress.value = value.toString(),
                  //           decoration: InputDecoration(
                  //             contentPadding: const EdgeInsets.all(30),
                  //             filled: true,
                  //             fillColor: const Color(0xFFF6F6F6),
                  //             hintText: 'Address',
                  //             prefixIcon: Icon(
                  //               TourMaker.location_icon,
                  //               color: fontColor,
                  //             ),
                  //             border: OutlineInputBorder(
                  //               borderSide:
                  //                   const BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(15),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderSide:
                  //                   const BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(15),
                  //             ),
                  //             errorBorder: OutlineInputBorder(
                  //               borderSide:
                  //                   const BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(15),
                  //             ),
                  //             focusedBorder: OutlineInputBorder(
                  //               borderSide:
                  //                   const BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(15),
                  //             ),
                  //             disabledBorder: OutlineInputBorder(
                  //               borderSide:
                  //                   const BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(15),
                  //             ),
                  //             focusedErrorBorder: OutlineInputBorder(
                  //               borderSide:
                  //                   const BorderSide(color: Colors.transparent),
                  //               borderRadius: BorderRadius.circular(15),
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(height: 15),
                  //         Obx(() {
                  //           return CustomButton().showIconButtonWithGradient(
                  //             height: 75,
                  //             width: 100.h,
                  //             isLoading: controller.isloading.value,
                  //             text: '     Submit',
                  //             onPressed: () => controller.onRegisterClicked(),
                  //           );
                  //         }),
                  //       ],
                  //     ),
                  //   ),
                  // )
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
      transitionDuration: const Duration(milliseconds: 500),
      useSafeArea: true,
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          borderRadius: BorderRadius.circular(25),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: controller.formKey,
              child: Column(
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
                  CustomTextFormField(
                    keyboardType: TextInputType.name,
                    contentPadding: const EdgeInsets.all(8),
                    prefix: Icon(TourMaker.profile_icon, color: fontColor),
                    hintText: 'Name',
                    validator: (String? value) =>
                        controller.nameValidator(value),
                    onChanged: (String value) =>
                        controller.customerName.value = value,
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    keyboardType: TextInputType.phone,
                    contentPadding: const EdgeInsets.all(8),
                    hintText: 'Phone Number',
                    validator: (String? value) =>
                        controller.phoneNumberValidator(value),
                    onChanged: (String? value) =>
                        controller.customerPhone.value = value.toString(),
                    prefix: Icon(TourMaker.call, color: fontColor),
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
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          '   Aadhar Card',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                  const SizedBox(height: 15),
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
