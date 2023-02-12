import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/style.dart';

import '../controllers/trip_details_controller.dart';

class TripDetailsView extends GetView<TripDetailsController> {
  const TripDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
              children: const <Widget>[
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
              children: <Widget>[
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
                        children: <Widget>[
                          Text(
                            'All India Tour',
                            style: heading2,
                          ),
                          Text('K2KL', style: subheading1),
                          Row(
                            children: <Widget>[
                              Text('Tour Desription', style: paragraph1),
                              const Spacer(),
                              Text('₹5100/person', style: paragraph1),
                            ],
                          ),
                          const Text('Test description of the tour'),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                            label: const Text('View Itinerary'),
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
