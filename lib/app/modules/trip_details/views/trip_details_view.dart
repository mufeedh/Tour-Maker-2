import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tour_maker/core/theme/style.dart';

import '../controllers/trip_details_controller.dart';

class TripDetailsView extends GetView<TripDetailsController> {
  const TripDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/Thumbnail.png',
            height: 100.w,
            width: 100.w,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100,
            left: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'Kashmir',
                    style: TextStyle(
                      fontFamily: 'Tahu',
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '    Tours',
                    style: TextStyle(
                      fontFamily: 'Tahu',
                      fontSize: 30,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.w - 30,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'All India Tour',
                            style: heading2,
                          ),
                          Text("K2KL", style: subheading1),
                          Row(
                            children: [
                              Text('Tour Desription', style: paragraph1),
                              Spacer(),
                              Text('₹5100/person', style: paragraph1),
                            ],
                          ),
                          Text("Test description of the tour"),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.share),
                            label: Text("View Itinerary"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
