import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_maker/core/theme/style.dart';

import '../../core/tour_maker_icons.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              Text('Hi John', style: heading2),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 33.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(TourMaker.vector, color: englishViolet),
                        const Text('Rewards'),
                      ],
                    ),
                  ),
                  Container(
                    width: 33.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(TourMaker.transaction_arrow_1,
                            color: englishViolet),
                        const Text('Payments'),
                      ],
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
                    children: [
                      Icon(TourMaker.notification, color: englishViolet),
                      const Text('Notifications'),
                      Switch(
                        value: true,
                        activeColor: englishViolet,
                        onChanged: (value) {},
                      ),
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
                leading: Icon(TourMaker.help, color: englishViolet),
                title: const Text('Help'),
              ),
              ListTile(
                leading: Icon(TourMaker.info_circle, color: englishViolet),
                title: const Text('about'),
              ),
              ListTile(
                leading: Icon(TourMaker.vector_2, color: englishViolet),
                title: const Text('Feedback'),
              ),
              ListTile(
                leading: Icon(TourMaker.logout, color: englishViolet),
                title: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
