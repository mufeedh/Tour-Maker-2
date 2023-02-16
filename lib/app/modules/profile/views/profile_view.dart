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
import '../../../widgets/custom_loadinscreen.dart';
import '../../../widgets/my_drawer.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: const CustomAppBar(
          titleText: 'Profile',
        ),
        body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (dynamic state) => Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Obx(
                        () => controller.selectedImagePath.value == ''
                            ? const SizedBox(
                                height: 190,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      AssetImage('assets/Avatar.png'),
                                ),
                              )
                            : Image.file(
                                File(controller.selectedImagePath.value)),
                      ),
                      Positioned(
                        top: 140,
                        left: 55,
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
                  buildListTile(TourMaker.profile_icon,
                      controller.userData.value.userName.toString()),
                  buildListTile(TourMaker.call,
                      controller.userData.value.phoneNumber.toString()),
                  buildListTile(TourMaker.location_icon,
                      controller.userData.value.state.toString()),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton().showIconButtonWithGradient(
                        height: 12.h,
                        width: 100.h,
                        text: '     Pay Service Charge Now',
                        onPressed: () {},
                      ))
                ],
              ),
            ),
          ),
        ));
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
                  onTap: () => controller.getImage(ImageSource.gallery),
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt_rounded, color: englishViolet),
                  title: const Text('Camera'),
                  onTap: () => controller.getImage(ImageSource.camera),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListTile(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 30),
          const SizedBox(width: 20),
          Text(label, style: subheading1),
        ],
      ),
    );
  }
}
