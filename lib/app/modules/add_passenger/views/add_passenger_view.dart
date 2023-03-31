import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
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
      child: Obx(() {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: const CustomAppBar(),
          resizeToAvoidBottomInset: true,
          body: controller.obx(
            onLoading: const CustomLoadingScreen(),
            (AddPassengerView? state) => Obx(
              () => controller.travellers.isEmpty
                  ? Padding(
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
                              '${controller.travellers.length}/${controller.totalTravellers} passengers added',
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
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 43),
                            Text(
                              'Enter Passenger Details',
                              style: heading2,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              '${controller.travellers.length}/${controller.totalTravellers} passengers added',
                              style: subheading3,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.travellers.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('name : '),
                                          Text(
                                            controller
                                                .travellers.value[index].name
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: fontColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('order ID : '),
                                          Text(
                                            controller
                                                .travellers.value[index].orderId
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: fontColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('phone number : '),
                                          Text(
                                            controller.travellers.value[index]
                                                .phoneNumber
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: fontColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('DOB : '),
                                          Text(
                                            controller
                                                .travellers[index].dateOfBirth
                                                .toString()
                                                .parseFromIsoDate()
                                                .toDocumentDateFormat(),
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: fontColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('address : '),
                                          Text(
                                            controller.travellers[index].address
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: fontColor,
                                            ),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          floatingActionButtonLocation:
              controller.totalTravellers == controller.travellers.length
                  ? FloatingActionButtonLocation.centerFloat
                  : FloatingActionButtonLocation.endFloat,
          floatingActionButton:
              controller.totalTravellers == controller.travellers.length
                  ? FloatingActionButton.extended(
                      onPressed: () => controller.gotoCheckoutPage(),
                      backgroundColor: englishViolet,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      label: const Text('Go to checkout'),
                    )
                  : FloatingActionButton(
                      onPressed: () => showAddPassengerDialogue(context),
                      backgroundColor: englishViolet,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      child: const Icon(Icons.add),
                    ),
        );
      }),
    );
  }

  Future<dynamic> showAddPassengerDialogue(BuildContext context) {
    return Get.bottomSheet(
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      elevation: 10,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
      Material(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: SingleChildScrollView(
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
                    isTime: true,
                    labelName: 'Date Of Birth',
                    validator: (String? value) =>
                        controller.dobValidator(value),
                    onChange: (String value) =>
                        controller.customerDOB.value = value,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    maxLines: 10,
                    minLines: 1,
                    validator: (String? value) =>
                        controller.addressValidator(value),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Obx(
                        () => controller.image.value != ''
                            ? Column(
                                children: [
                                  Text('Adhaar Card'),
                                  Image.file(File(controller.image.value)),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    '      Aadhar Card',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.camera_alt),
                                    onPressed: () {
                                      onClickCamera(context);
                                    },
                                  ),
                                ],
                              ),
                      )),
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
