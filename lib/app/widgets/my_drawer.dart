import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/style.dart';

import '../../core/tour_maker_icons.dart';
import '../data/models/user_model.dart';
import '../routes/app_pages.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, this.controller});
  final UserModel? controller;

  @override
  Widget build(BuildContext context) {
    final Rx<bool> isNotificationON = true.obs;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 38.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Hi ${controller?.name}', style: heading2),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => onClickRewards(),
                    child: Container(
                      width: 33.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(TourMaker.vector, color: englishViolet),
                          const Text('Rewards'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onClickPayments(),
                    child: Container(
                      width: 33.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(TourMaker.transaction_arrow_1,
                              color: englishViolet),
                          const Text('Payments'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(TourMaker.notification, color: englishViolet),
                      const Text('Notifications'),
                      Obx(() {
                        return Switch(
                          value: isNotificationON.value,
                          activeColor: englishViolet,
                          onChanged: (bool value) {
                            isNotificationON.value = value;
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(TourMaker.group_2, color: englishViolet),
                title: const Text('Privacy Policy'),
              ),
              ListTile(
                leading: Icon(TourMaker.group, color: englishViolet),
                title: const Text('Terms Of Use'),
              ),
              ListTile(
                onTap: onClickHelp,
                leading: SvgPicture.asset('assets/help.svg', height: 25),
                title: const Text('Help'),
              ),
              ListTile(
                leading: SvgPicture.asset('assets/about.svg', height: 25),
                title: const Text('about'),
              ),
              ListTile(
                onTap: onClickFeedBack,
                leading: SvgPicture.asset('assets/feedback.svg', height: 25),
                title: const Text('Feedback'),
              ),
              ListTile(
                onTap: () => onLogoutPressed(context),
                leading: Icon(TourMaker.logout, color: englishViolet),
                title: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLogoutPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 260, horizontal: 25),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Do you really want to logout \n from TourMaker?',
                  textAlign: TextAlign.center,
                  style: subheading2,
                ),
                const Divider(),
                GestureDetector(
                  onTap: () => logout(),
                  child: Text('Logout', style: subheading2),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () => cancel(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      // fontFamily: montserratMedium,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onClickRewards() => Get.toNamed(Routes.REWARDS);

  void onClickPayments() => Get.toNamed(Routes.PAYMENT_SCREEN);

  Future<void> onClickHelp() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'tourmakerapp@gmail.com',
      query:
          'subject=I am ${controller?.name} , and i need a help from TourMaker',
    );
    final String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar('SORRY!!!', 'Could not launch $url');
    }
  }

  Future<void> onClickFeedBack() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'tourmakerapp@gmail.com',
      query: 'subject=Hi , I am ${controller?.name}',
    );
    final String url = params.toString();
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar('SORRY!!!', 'Could not launch $url');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance
        .signOut()
        .then((dynamic value) => Get.offAllNamed(Routes.GET_STARTED));
  }

  void cancel() => Get.back();
}
