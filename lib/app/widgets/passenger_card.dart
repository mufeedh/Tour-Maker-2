import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/style.dart';
import '../../core/utils/date_utils.dart';
import '../../core/utils/string_utils.dart';
import '../data/models/network_models/travellers_model.dart';

class PassengerCard extends StatelessWidget {
  const PassengerCard({super.key, required this.travellers});
  final TravellersModel travellers;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  const Text('name : '),
                  Text(
                    travellers.name.toString(),
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
                children: <Widget>[
                  const Text('order ID : '),
                  Text(
                    travellers.orderId.toString(),
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
                children: <Widget>[
                  const Text('phone number : '),
                  Text(
                    travellers.phoneNumber.toString(),
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
                children: <Widget>[
                  const Text('DOB : '),
                  Text(
                    travellers.dateOfBirth
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
                children: <Widget>[
                  const Text('address : '),
                  SizedBox(
                    width: 200,
                    child: Text(
                      travellers.address.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: fontColor,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  const Text('ID proof : '),
                  Text(
                    ' added ✔️',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
