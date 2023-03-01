import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_errorscreen.dart';
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/my_drawer.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      drawer: Obx(() {
        return MyDrawer(controller: controller.userData.value);
      }),
      appBar: const CustomAppBar(
        titleText: 'Profile',
      ),
      body: controller.obx(
        onError: (String? e) => CustomErrorScreen(errorText: '$e'),
        onLoading: const CustomLoadingScreen(),
        (ProfileView? state) => Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Obx(
                      () => controller.filePath.value == null
                          ? const SizedBox(
                              height: 180,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  'assets/Avatar.png',
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 180,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  Image.file(File(controller.filePath.value!))
                                      .toString(),
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 130,
                      left: 43,
                      child: GestureDetector(
                        onTap: () => onClckProfileIcon(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: englishViolet,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/camera.svg',
                              fit: BoxFit.cover,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  return buildTile(
                      icon: TourMaker.profile_icon,
                      data: controller.userData.value.name.toString(),
                      label: 'Full Name');
                }),
                Obx(() {
                  return buildTile(
                    icon: TourMaker.call,
                    data: controller.userData.value.phoneNumber.toString(),
                    label: 'Phone Number',
                  );
                }),
                Obx(() {
                  return buildTile(
                      icon: TourMaker.location_icon,
                      label: 'State',
                      data: controller.userData.value.state.toString());
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton().showIconButtonWithGradient(
                      height: 75,
                      width: 100.h,
                      isLoading: controller.isloading.value,
                      text: '  Pay Service Charge Now',
                      onPressed: () => controller.onClickPayment(),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onClckProfileIcon(BuildContext context) {
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
                    onTap: () => controller.onPickedFromGallery()),
                ListTile(
                  leading: Icon(Icons.camera_alt_rounded, color: englishViolet),
                  title: const Text('Camera'),
                  onTap: () => controller.onPickedFromCamera(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTile(
      {required IconData icon, required String label, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 23),
      child: Container(
        width: 100.w,
        height: 85,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 232, 231, 233),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, color: fontColor),
                ],
              ),
              const SizedBox(width: 15),
              VerticalDivider(
                color: Colors.grey.shade600,
                endIndent: 10,
                indent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(label, style: paragraph3),
                    Text(data, style: subheading2),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
