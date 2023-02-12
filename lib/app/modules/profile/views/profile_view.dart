import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                const SizedBox(
                  height: 190,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/Avatar.png'),
                  ),
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
            buildListTile(TourMaker.profile_icon, 'konjaanesh PK'),
            buildListTile(TourMaker.email_icon, 'kannappi@daddyboy.com'),
            buildListTile(TourMaker.call, '+788989489290'),
            buildListTile(TourMaker.profile_icon, '+788989489290'),
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
                  onTap: () => controller.onPickedFromGallery(),
                ),
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

  Widget buildListTile(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 30),
          const SizedBox(width: 20),
          Text(label, style: heading3),
        ],
      ),
    );
  }
}
