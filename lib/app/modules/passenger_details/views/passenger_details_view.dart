import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/tour_maker_icons.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/passenger_details_controller.dart';

class PassengerDetailsView extends GetView<PassengerDetailsController> {
  const PassengerDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Passenger Details'),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 240, 241),
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) => Container(
                  height: 162,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(TourMaker.profile_icon, color: fontColor),
                          SizedBox(width: 5),
                          Text('JOHN Jacob'),
                          Spacer(),
                          Text('Ck2D'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(TourMaker.call, color: fontColor),
                          SizedBox(width: 5),
                          Text('+91987654321'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(TourMaker.location_icon, color: fontColor),
                          SizedBox(width: 5),
                          Text(
                            'Address of the residence of\n passenger who \nlived in anywhere in the world',
                            style: subheading3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
