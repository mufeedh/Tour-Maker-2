import 'package:flutter/material.dart';

import '../../core/theme/style.dart';
import '../../core/tour_maker_icons.dart';

class BookingTile extends StatelessWidget {
  const BookingTile(
      {super.key,
      required this.onTapIcon,
      required this.tourName,
      required this.tourAmount,
      required this.tourCode,
      required this.tourPersons,
      required this.tourAmountCriteria});
  final void Function() onTapIcon;

  final String tourName;
  final String tourAmount;
  final String tourCode;
  final String tourPersons;
  final String tourAmountCriteria;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(tourName, style: paragraph2),
                  Text(tourAmountCriteria, style: paragraph4),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(tourCode, style: paragraph2),
                  Text(tourAmount, style: paragraph4),
                ],
              ),
            ),
            GestureDetector(
              onTap: onTapIcon,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 76,
                    height: 88,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                      color: englishViolet,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            TourMaker.people,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tourPersons,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
